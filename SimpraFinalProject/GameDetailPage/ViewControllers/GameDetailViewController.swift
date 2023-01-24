//
//  GameDetailViewController.swift
//  LegendaryApp
//
//  Created by Furkan Deniz Albaylar on 22.01.2023.
//

import UIKit
import Kingfisher

class GameDetailViewController: UIViewController {

    @IBOutlet weak var likeGameOutlet: UIButton!
    @IBOutlet weak var detailText: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var gameImageView: UIImageView!
    var gameId: Int?
    //   var delegateFavorite: FavoriteViewController?
    private var viewModel: GameDetailSceneViewModelProtocol = GameDetailSceneViewModel()
    
    //MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let id = gameId else { return }
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleError),
                                               name: NSNotification.Name("detailGamesErrorMessage"),
                                               object: nil)
        gameImageView.layer.cornerRadius = 20
        viewModel.delegate = self
        viewModel.fetchGameDetail(id)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isBeingDismissed {
            if Globals.sharedInstance.isFavoriteChanged{
                //           delegateFavorite?.viewWillAppear(true)
            }
        }
    }
    //MARK: - Actions
    @IBAction func pressLikeGame(_ sender: Any) {
        favoriteHandler(status: viewModel.handleFavorite())
    }
    private func favoriteHandler(status:Bool?){
        if let status{
            if status{
                likeGameOutlet.setImage(UIImage(systemName: "star.fill"), for: .normal)
            }else{
                likeGameOutlet.setImage(UIImage(systemName: "star"), for: .normal)
            }
            likeGameOutlet.isHidden = false
            return
        }
        likeGameOutlet.isHidden = true
        return
    }
}

//MARK: - Delegate Functions
extension GameDetailViewController: GameDetailSceneViewModelDelegate{
    func gameLoaded() {
            if let id = self.gameId{
                self.favoriteHandler(status: self.viewModel.isFavoriteGame(id))
            }
            self.publisherLabel.text = self.viewModel.getGamePublisher()
            self.titleLabel.text = self.viewModel.getGameTitle()
            self.detailText.text = self.viewModel.getGameDetail()
        self.gameImageView.kf.indicatorType = .activity
        self.gameImageView.kf.setImage(with: self.viewModel.getGameImageUrl(640), placeholder: nil){_ in
        }

    }
    
    
}
