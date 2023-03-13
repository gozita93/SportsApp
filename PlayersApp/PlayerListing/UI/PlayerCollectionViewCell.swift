//
//  PlayerCollectionViewCell.swift
//  PlayersApp
//
//  Created by Visakh Simon Tharakan on 13/03/23.
//

import UIKit
import Kingfisher

final class PlayerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var clubNameLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var cellViewModel: PlayerItemCellViewModel? {
        didSet {
            guard let model = cellViewModel else {
                return
            }
            clubNameLabel.text = model.player.teamName
            playerNameLabel.text = model.player.name
            profileImageView.kf.setImage(with: URL(string: model.player.photo))
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        build()
    }
    
    func configureCell(withViewModel viewModel: PlayerItemCellViewModel) {
        cellViewModel = viewModel
    }

}

extension PlayerCollectionViewCell {

    func build() {
        configureView()
    }
    
    func configureView() {
        profileImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        profileImageView.layer.cornerRadius = 10.0
        cellContentView.layer.cornerRadius = 10.0
        cellContentView.layer.shadowColor = UIColor(
            red: 0,
            green: 0,
            blue: 0,
            alpha: 0.15
        ).cgColor
        cellContentView.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        cellContentView.layer.shadowRadius = 10.0
        cellContentView.layer.shadowOpacity = 1
        cellContentView.layer.masksToBounds = false
    }

}

extension UICollectionViewCell {

    static var reuseIdentifier: String {
        String(describing: self)
    }
    
    static var nib: UINib {
        UINib(nibName: reuseIdentifier, bundle: nil)
    }

}
