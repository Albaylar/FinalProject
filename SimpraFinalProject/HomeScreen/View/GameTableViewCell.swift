//
//  GameTableViewCell.swift
//  LegendaryApp
//
//  Created by Furkan Deniz Albaylar on 22.01.2023.
//

import UIKit
import Kingfisher

class GameTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var gameInfo: UILabel!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var gameImage: UIImageView!
    
    //MARK: - Lifecycle Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        gameImage.layer.cornerRadius = 7.5
        cellView.layer.cornerRadius = 40
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        
        gameImage.image = nil
    }

    
    //MARK: - Public Functions
    func configureCell(_ game:RawgModel){
        gameTitle.text = game.name
        gameInfo.text = gameInfoCreator(game)
        changeImage(imgUrl: game.imageWide)
    }
    
    
    //MARK: - UI Helpers
    private func gameInfoCreator(_ game:RawgModel) -> String{
        let dateString = (game.tba ?? false) ? "TBA" : (game.released?.prefix(4) ?? "TBA")
        var genreString = ""
        if let genres = game.genres, ((game.genres?.count ?? 0) != 0){
            for i in genres{
                genreString += i.name ?? ""
                genreString += ", "
            }
            genreString.removeLast(2)
        }
        return "\(dateString) | \(genreString) "
    }

    
    //MARK: - Private Functions
    private func changeImage(imgUrl:String?){
        if let imgSized = Globals.sharedInstance.resizeImageRemote(imgUrl: imgUrl){
            guard let url = URL(string: imgSized) else { return }
            DispatchQueue.main.async {
                self.gameImage.kf.setImage(with: url, placeholder: nil)
            }
        }
    }
}
