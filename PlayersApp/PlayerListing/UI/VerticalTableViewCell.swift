//
//  VerticalTableViewCell.swift
//  PlayersApp
//
//  Created by Visakh Simon Tharakan on 13/03/23.
//

import UIKit

final class VerticalTableViewCell: UITableViewCell {

    @IBOutlet weak var tableView: UITableView!
    var cellViewModel: PlayerListViewModel? {
        didSet {
            tableView.reloadData()
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

extension VerticalTableViewCell {
    func build() {
        bind()
        configureView()
    }
    
    func bind() {
        tableView.register(PlayerTableViewCell.nib, forCellReuseIdentifier: PlayerTableViewCell.reuseIdentifier)
    }
    
    func configureView() {
        tableView.layer.cornerRadius = 8
    }
}

extension VerticalTableViewCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = cellViewModel else {
            return 0
        }
        return viewModel.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PlayerTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? PlayerTableViewCell,
                let playerModel = cellViewModel else {
            return UITableViewCell()
        }

        let playerItemModel = playerModel.players[indexPath.row]
        let playerCellViewModel = PlayerItemCellViewModel(player: playerItemModel)

        cell.configureCell(withViewModel: playerCellViewModel)
        return cell

    }
    
    
}
