//
//  PlayerListViewController.swift
//  PlayersApp
//
//  Created by Visakh Simon Tharakan on 11/03/23.
//

import UIKit

final class PlayerListViewController: UIViewController {

    @IBOutlet weak var searchHeaderView: SearchHeaderView!
    @IBOutlet weak var mainTableView: UITableView!
    lazy var activityIndicator = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        return activityIndicator
    }()

    let viewModel: PlayerListViewModel = {
        let remoteService = RemotePlayerService(session: URLSession.shared)
        return PlayerListViewModel(playerService: remoteService)
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        build()
        viewModel.loadPlayers()
    }
    
    func showLoadingIndicator(_ isStarted: Bool) {
        DispatchQueue.main.async { [unowned self] in
            if isStarted {
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
            }
        }
    }

}

extension PlayerListViewController {
    func build() {
        buildViews()
        bind()
    }
    
    func buildViews() {
        view.addSubview(activityIndicator)
        view.bringSubviewToFront(activityIndicator)
    }
    
    func bind() {
        viewModel.delegate = self
        mainTableView.register(VerticalTableViewCell.nib, forCellReuseIdentifier: VerticalTableViewCell.reuseIdentifier)
        mainTableView.register(HorizontalTableViewCell.nib, forCellReuseIdentifier: HorizontalTableViewCell.reuseIdentifier)
        mainTableView.register(SectionHeaderView.nib, forHeaderFooterViewReuseIdentifier: SectionHeaderView.reuseIdentifier)
    }
}

extension PlayerListViewController: LoadPlayersViewModelDelegate {
    func onLoadSuccess() {
        DispatchQueue.main.async { [weak self] in
            self?.mainTableView.reloadData()
        }
    }
    
    func onLoadFailure(error: Error) {
        print(error.localizedDescription)
    }
    
    func onLoadStarted(_ isStarted: Bool) {
        showLoadingIndicator(isStarted)
    }
}

extension PlayerListViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int { viewModel.section.count }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { viewModel.section[section].numberOfItems }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch viewModel.section[indexPath.section] {
        case .topPlayer:
            guard let cell = mainTableView.dequeueReusableCell(withIdentifier: HorizontalTableViewCell.reuseIdentifier, for: indexPath) as? HorizontalTableViewCell else {
                return UITableViewCell()
            }

            cell.configureCell(withViewModel: viewModel)
            return cell
            
        case .allPlayer:
            guard let cell = mainTableView.dequeueReusableCell(withIdentifier: VerticalTableViewCell.reuseIdentifier, for: indexPath) as? VerticalTableViewCell else {
                return UITableViewCell()
            }

            cell.configureCell(withViewModel: viewModel)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel.section[indexPath.section]{
        case .topPlayer:
            return 192.0
        case .allPlayer:
            return CGFloat(64 * viewModel.players.count + 30)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = mainTableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderView.reuseIdentifier) as? SectionHeaderView else {
            return nil
        }
        
        headerView.headerLabel.text = viewModel.section[section].rawValue 
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }
}
