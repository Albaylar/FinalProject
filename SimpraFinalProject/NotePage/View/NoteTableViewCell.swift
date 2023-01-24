//
//  NoteTableViewCell.swift
//  SimpraFinalProject
//
//  Created by Furkan Deniz Albaylar on 23.01.2023.
//

import UIKit


class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var noteDetail: UITextView!
    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MARK: - Global Functions
    func configureCell(_ note:Note){
        gameTitle.text = note.gameTitle
        noteTitle.text = note.noteTitle
        noteDetail.text = note.noteDetail
    }
    

}
