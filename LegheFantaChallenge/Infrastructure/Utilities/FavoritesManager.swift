//
//  FavoritesManager.swift
//  LegheFantaChallenge
//
//  Created by Alessandro Di Majo on 13/10/23.
//

import Foundation

class FavoritesManager {
    static let shared = FavoritesManager()
    
    var favoritePlayers: [FootballPlayer] = [] {
        didSet {
            print("favoritePlayers changed")
            
            let sortedPlayers = favoritePlayers.sorted { (player1, player2) in
                if player1.teamAbbreviation != player2.teamAbbreviation {
                    return player1.teamAbbreviation < player2.teamAbbreviation
                } else {
                    return player1.playerName < player2.playerName
                }
            }
            UserDefaultsConfig.favoritePlayers = sortedPlayers
            NotificationCenter.default.post(name: Notification.Name(Constants.Notifications.favoritesUpdated.rawValue), object: nil)
        }
    }
    
    private init() {
        favoritePlayers = UserDefaultsConfig.favoritePlayers ?? []
    }
    
    func managePlayer(footballPlayer: FootballPlayer) {
        if let index = favoritePlayers.firstIndex(where: { $0.playerId == footballPlayer.playerId}) {
            print("Removing \(footballPlayer.playerName)")
            favoritePlayers.remove(at: index)
        } else {
            print("Adding \(footballPlayer.playerName)")
            favoritePlayers.append(footballPlayer)
        }
    }
}
