//
//  PlayerListViewModel.swift
//  PlayersApp
//
//  Created by Visakh Simon Tharakan on 12/03/23.
//

import Foundation

public protocol LoadPlayersViewModelDelegate: AnyObject {
    func onLoadSuccess()
    func onLoadFailure(error: Error)
    func onLoadStarted(_ isStarted: Bool)
}

enum Section: String {
    case topPlayer = "Top Player"
    case allPlayer = "All Player"
    
    var numberOfItems: Int {
        switch self {
        case .allPlayer:
            return 1
        case .topPlayer:
            return 1
        }
    }
}

public final class PlayerListViewModel {
    let playerService: PlayersService
    var players: [PlayerItem] = [PlayerItem]()
    
    var section: [Section] = []
    
    init(playerService: PlayersService) {
        self.playerService = playerService
    }
    
    weak var delegate: LoadPlayersViewModelDelegate?

    func loadPlayers() {
        self.delegate?.onLoadStarted(true)

        playerService.load{ [weak self] result in
            guard let self = self else { return }
            
            self.delegate?.onLoadStarted(false)
            switch result {
            case let .success(playersList):
                self.players = playersList
                self.section = [.topPlayer, .allPlayer]
                self.delegate?.onLoadSuccess()
            case let .failure(error):
                self.delegate?.onLoadFailure(error: error)
            }
        }
    }
}
