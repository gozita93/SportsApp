//
//  RemotePlayerList.swift
//  PlayersApp
//
//  Created by Visakh Simon Tharakan on 13/03/23.
//

import Foundation

struct RemotePlayerList: Decodable {
    let status: Int
    let message: String
    let data: [RemotePlayerItem]
    let total, perPage: Int

    enum CodingKeys: String, CodingKey {
        case status, message, data, total
        case perPage = "per_page"
    }
}

struct RemotePlayerItem: Decodable {
    let name: String
    let photo: String
    let rating: String
    let teamName:String
    let positionName: String
    
    enum CodingKeys: String, CodingKey {
        case name, photo, rating
        case teamName = "team_name"
        case positionName = "position_name"
    }
    
    var playerItem: PlayerItem {
        PlayerItem(
            name: name,
            photo: photo,
            rating: rating,
            teamName: teamName,
            positionName: positionName
        )
    }
}
