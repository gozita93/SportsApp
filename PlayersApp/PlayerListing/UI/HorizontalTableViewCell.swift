//
//  HorizontalTableViewCell.swift
//  PlayersApp
//
//  Created by Visakh Simon Tharakan on 13/03/23.
//

import UIKit

final class HorizontalTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var cellViewModel: PlayerListViewModel? {
        didSet {
            collectionView.reloadData()
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
    
    func configureCell(withViewModel viewModel: PlayerListViewModel) {
        self.cellViewModel = viewModel
    }
    
}
extension HorizontalTableViewCell {
    func build() {
        bind()
    }
    
    func bind() {
        collectionView.register(PlayerCollectionViewCell.nib, forCellWithReuseIdentifier: PlayerCollectionViewCell.reuseIdentifier)
    }
}

extension HorizontalTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = cellViewModel else {
            return 0
        }

        return viewModel.players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PlayerCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? PlayerCollectionViewCell,
        let playerModel = cellViewModel else {
            return UICollectionViewCell()
        }
        
        let cellViewModel = PlayerItemCellViewModel(player: playerModel.players[indexPath.row])
        
        cell.configureCell(withViewModel: cellViewModel)
        return cell
    }
}
