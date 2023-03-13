//
//  PlayerTableViewCell.swift
//  PlayersApp
//
//  Created by Visakh Simon Tharakan on 13/03/23.
//

import UIKit
import Kingfisher

final class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var cellBGView: UIView!
    @IBOutlet weak var ratingBGView: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var clubNameLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var cellViewModel: PlayerItemCellViewModel? {
        didSet {
            guard let model = cellViewModel else {
                return
            }
            ratingLabel.text = model.player.rating
            positionLabel.text = model.player.positionName
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(withViewModel viewModel: PlayerItemCellViewModel) {
        self.cellViewModel = viewModel
    }
    
}

extension PlayerTableViewCell {
    
    func build() {
        configureView()
    }
    
    func configureView() {
        profileImageView.layer.cornerRadius = 8
        cellBGView.layer.cornerRadius = 8
        ratingBGView.layer.cornerRadius = 8
    }
    
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        String(describing: self) 
    }
    
    static var nib: UINib {
        UINib(nibName: reuseIdentifier, bundle: nil)
    }
}
