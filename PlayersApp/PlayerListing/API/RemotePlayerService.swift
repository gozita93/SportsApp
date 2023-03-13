//
//  RemotePlayerService.swift
//  PlayersApp
//
//  Created by Visakh Simon Tharakan on 12/03/23.
//

import Foundation

public class RemotePlayerService: PlayersService {
    let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    func load(completion: @escaping PlayersService.Completion) {
        guard let url = URL(string: "https://ios.app99877.com/api/sc/players") else { return }

        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching player list: \(error)")
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            if let data = data,
               let result = try? JSONDecoder().decode(RemotePlayerList.self, from: data) {
                let playerList = result.data.map{
                    PlayerItem(
                        name: $0.name,
                        photo: $0.photo,
                        rating: $0.rating,
                        teamName: $0.teamName,
                        positionName: $0.positionName
                    )
                }
                completion(.success(playerList))
            }
        })

        task.resume()
    }
}
