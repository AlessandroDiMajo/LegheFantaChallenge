//
//  PlayersViewModel.swift
//  LegheFantaChallenge
//
//  Created by Alessandro Di Majo on 12/10/23.
//

import Foundation
import RxCocoa

class PlayersViewModel {
    
    fileprivate let url: URL = URL(string: "https://content.fantacalcio.it/test/test.json")!
    let footballPlayersRelay: BehaviorRelay<[FootballPlayer]> = BehaviorRelay<[FootballPlayer]>(value: [])
    let footballPlayersFilteredRelay: BehaviorRelay<[FootballPlayer]> = BehaviorRelay<[FootballPlayer]>(value: [])
    var isFirstFetchDone: Bool = false
    
    init() {}

    func retrieveFootballPlayers(completion: (() -> Void)?) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let data = data {
                do {
                    let footballPlayerDTOs = try JSONDecoder().decode([FootballPlayerDTO].self, from: data)
                    let footballPlayers = footballPlayerDTOs.map { dto in
                        return dto.toDomainModel()
                    }
                    self?.footballPlayersRelay.accept(footballPlayers)
                    self?.footballPlayersFilteredRelay.accept(footballPlayers)
                    print("Hai ben \(footballPlayers.count) calciatori")
                } catch {
                    print("Errore durante la decodifica del JSON: \(error)")
                }
                completion?()
            }
        }.resume()
    }
    
    func filterFootballPlayersList(text: String) {
        let lowerCasedText = text.lowercased()
        
        var filteredPlayers: [FootballPlayer] = footballPlayersRelay.value
        if !lowerCasedText.isEmpty {
            filteredPlayers = footballPlayersRelay.value.filter { player in
                let playerName = player.playerName.lowercased()
                return playerName.contains(lowerCasedText)
            }
        }
        let sortedPlayers = filteredPlayers.sorted { (player1, player2) in
            if player1.teamAbbreviation != player2.teamAbbreviation {
                return player1.teamAbbreviation < player2.teamAbbreviation
            } else {
                return player1.playerName < player2.playerName
            }
        }
            print("sortedPlayer now are \(sortedPlayers.count)")
        footballPlayersFilteredRelay.accept(sortedPlayers)
    }
    
    func didTappedStarButton(footballPlayer: FootballPlayer) {
        print("didTappedStarButton with \(footballPlayer.playerName)")
    }
}
