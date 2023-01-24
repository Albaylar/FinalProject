//
//  FavoriteTableViewCell.swift
//  SimpraFinalProject
//
//  Created by Furkan Deniz Albaylar on 22.01.2023.
//

import UIKit
import Kingfisher

class FavoriteTableViewCell: UITableViewCell {
    
    //MARK: - Outlets and Variables
    @IBOutlet weak var cellView: UIView!
    @IBOutlet private weak var gameImage: UIImageView!
    @IBOutlet private weak var gameTitle: UILabel!
    
    
    //MARK: - Life Cycle Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.cornerRadius = 40
        gameImage.layer.cornerRadius = 20
    }
    
    override func prepareForReuse() {
        gameImage.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Public Functions
    func configureCell(_ game:GameDetailModel){
        gameTitle.text = game.name
        changeImage(imgUrl: game.imageWide)
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
