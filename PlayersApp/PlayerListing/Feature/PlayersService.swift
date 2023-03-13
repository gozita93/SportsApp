//
//  PlayersService.swift
//  PlayersApp
//
//  Created by Visakh Simon Tharakan on 13/03/23.
//

import Foundation

protocol PlayersService {
    typealias Completion = (Result<[PlayerItem], Error>) -> Void
    
    func load(completion: @escaping Completion)
}
