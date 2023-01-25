//
//  NoteViewController.swift
//  SimpraFinalProject
//

//  Created by Furkan Deniz Albaylar on 23.01.2023.
//
import UIKit

class NoteViewController: UIViewController {
    
    //MARK: - Outlets and Variables
    @IBOutlet private weak var newNoteButton: UIButton!
    @IBOutlet private weak var noteListTableView: UITableView!{
        didSet{
            noteListTableView.delegate = self
            noteListTableView.dataSource = self
            noteListTableView.register(UINib(nibName: "NoteTableViewCell", bundle: nil), forCellReuseIdentifier: "noteCell")
            noteListTableView.rowHeight = 200
        }
    }
    
    private var viewModel: NoteViewModelProtocol = NoteViewModel()
    
    //MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = NSLocalizedString("Notes", comment: "Notes Page")
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleError),
                                               name: NSNotification.Name("noteGamesErrorMessage"),
                                               object: nil)
        viewModel.delegate = self
       
        viewModel.fetchNotes()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(Globals.sharedInstance.isNotesChanged){
            viewModel.fetchNotes()
        }
    }
    //MARK: - Segue Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "NotestoNoteDetail":
            if let note = sender as? Note{
                let goalVC = segue.destination as! NoteDetailViewController
                let game = RawgModel(id: Int(note.gameId), tba: nil, name: note.gameTitle, released: nil, metacritic: nil, rating: nil, parentPlatforms: nil, genres: nil, imageWide: note.imageUrl)
                goalVC.delegateNoteScene = self
                goalVC.game = game
                goalVC.note = note
            }
        case "NotestoNewNote":
            let goalVC = segue.destination as! NoteDetailViewController
            goalVC.delegateNoteScene = self
        default:
            print("identifier not found")
        }
    }
    
    //MARK: - Actions
    @IBAction func newNoteAction(_ sender: Any) {
        performSegue(withIdentifier: "NotestoNewNote", sender: nil)
    }
    
}
//MARK: - Delegate Functions
extension NoteViewController: NoteViewModelDelegate {
    func notesLoaded() {
       // activityIndicator.stopAnimating()
        noteListTableView.reloadData()
    }
}
//MARK: - Tableview Functions
extension NoteViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         
        return viewModel.getNoteCount()
          }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as? NoteTableViewCell,
              let obj = viewModel.getNote(at: indexPath.row) else {return UITableViewCell()}
        DispatchQueue.main.async {
            cell.configureCell(obj)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let note = viewModel.getNote(at: indexPath.row){
            performSegue(withIdentifier: "NotestoNoteDetail", sender: note)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let note = viewModel.getNote(at: indexPath.row)
        
        let deleteConfirmAction = UIContextualAction(style: .destructive, title: NSLocalizedString("Delete", comment: "Delete")){ (contextualAction, view, bool ) in
            let alert = UIAlertController(title: NSLocalizedString("Do you want to delete this note", comment: "Do you want to delete this note?"), message: "\(note?.noteTitle! ?? "")", preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .cancel){action in
                tableView.reloadRows(at: [indexPath], with: .right)
                tableView.reloadData()
            }
            
            alert.addAction(cancelAction)
            
            let yesAction = UIAlertAction(title: NSLocalizedString("Delete a Note", comment: "Delete"), style: .destructive){action in
                self.viewModel.deleteNote(at: indexPath.row)
                tableView.reloadRows(at: [indexPath], with: .left)
                
            }
            alert.addAction(yesAction)
            
            if #available(iOS 16.0, *) {
                alert.popoverPresentationController?.sourceItem = self.newNoteButton
            } else {
            }
            self.newNoteButton.isHidden = false
            self.present(alert, animated: true)
            
        }
        return UISwipeActionsConfiguration(actions: [deleteConfirmAction])
        
    }
    
}

//MARK: - Scrollview Functions
extension NoteViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == noteListTableView{
            newNoteButton.isHidden = scrollView.contentOffset.y > 0
        }
    }
}
