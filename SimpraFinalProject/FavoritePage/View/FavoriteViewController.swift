//
//  FavoriteViewController.swift
//  SimpraFinalProject
//
//  Created by Furkan Deniz Albaylar on 24.01.2023.
//

import UIKit


class FavoriteViewController: UIViewController {
    
    //MARK: - Outlets and Variables
    
    

    @IBOutlet private weak var favoriteListTableView: UITableView!{
        didSet{
            favoriteListTableView.delegate = self
            favoriteListTableView.dataSource = self
            favoriteListTableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "favoriteCell")
            favoriteListTableView.rowHeight = 150.0
        }
    }
    
    private var viewModel: FavoriteViewModelProtocol = FavoriteViewModel()
    
    //MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = NSLocalizedString("Favorites", comment: "Favorite Games")
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleError),
                                               name: NSNotification.Name("favoriteGamesErrorMessage"),
                                               object: nil)
        
        viewModel.delegate = self

        viewModel.fetchFavoriteGames()
        Globals.sharedInstance.isFavoriteChanged = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Globals.sharedInstance.isFavoriteChanged{
            //activityIndicator.startAnimating()
            viewModel.fetchFavoriteGames()
        }
    }
    //MARK: - Segue Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "FavoritetoDetail":
            if let gameId = sender as? Int{
                let goalVC = segue.destination as! GameDetailViewController
                goalVC.gameId = gameId
    //            goalVC.delegateFavorite = self
            }
        default:
            print("identifier not found")
        }
    }
}

//MARK: - Delegate Functions

extension FavoriteViewController: FavoriteViewModelDelegate {
    func favoritesLoaded() {
        favoriteListTableView.reloadData()

    }
}

//MARK: - Tableview Functions
extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.getGameCount()
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoriteTableViewCell,
              let obj = viewModel.getGame(at: indexPath.row) else {return UITableViewCell()}
        DispatchQueue.main.async {
            cell.configureCell(obj)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let gameId = viewModel.getGameId(at: indexPath.row){
            performSegue(withIdentifier: "FavoritetoDetail", sender: gameId)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: NSLocalizedString("Delete a Fav", comment: "Remove Favorite")){ (contextualAction, view, bool ) in
            self.viewModel.removeGame(at: indexPath.row)
            tableView.reloadRows(at: [indexPath], with: .left)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}
