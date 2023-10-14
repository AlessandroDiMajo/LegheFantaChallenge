//
//  PlayersViewModel.swift
//  LegheFantaChallenge
//
//  Created by Alessandro Di Majo on 12/10/23.
//

import Foundation
import RxCocoa

class PlayersViewModel {
    
    enum PlayersViewModelError: Error {
        case somethingsWentWrong
        case decodingError
        
        var errorTitle: String {
            return "Errore"
        }
        
        var errorDescription: String {
            return "Qualcosa è andato storto!"
        }
    }
   
    let errorRelay = PublishRelay<PlayersViewModelError>()
    let footballPlayersRelay: BehaviorRelay<[FootballPlayer]> = BehaviorRelay<[FootballPlayer]>(value: [])
    let footballPlayersFilteredRelay: BehaviorRelay<[FootballPlayer]> = BehaviorRelay<[FootballPlayer]>(value: [])
    fileprivate let url: URL = URL(string: "https://content.fantacalcio.it/test/test.json")!
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(favoritesUpdated), name: Notification.Name(Constants.Notifications.favoritesUpdated.rawValue), object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func favoritesUpdated() {
        print("favoritesUpdated")
        let storedFootballPlayer = UserDefaultsConfig.favoritePlayers ?? []
        var updatedPlayers = footballPlayersRelay.value
        var updatedFilteredPlayers = footballPlayersFilteredRelay.value
        
        for (index, player) in updatedPlayers.enumerated() {
            if storedFootballPlayer.contains(where: { $0.playerId == player.playerId }) {
                updatedPlayers[index].isFavorite = true
            } else {
                updatedPlayers[index].isFavorite = false
            }
        }
        
        for (index, player) in updatedFilteredPlayers.enumerated() {
            if storedFootballPlayer.contains(where: { $0.playerId == player.playerId }) {
                updatedFilteredPlayers[index].isFavorite = true
            } else {
                updatedFilteredPlayers[index].isFavorite = false
            }
        }
        footballPlayersRelay.accept(updatedPlayers)
        footballPlayersFilteredRelay.accept(updatedFilteredPlayers)
    }

    func retrieveFootballPlayers(completion: (() -> Void)?) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            guard error == nil else {
                self.errorRelay.accept(.somethingsWentWrong)
                completion?()
                return
            }
            if let data = data {
                do {
                    let footballPlayerDTOs = try JSONDecoder().decode([FootballPlayerDTO].self, from: data)
                    let footballPlayers = footballPlayerDTOs.map { dto in
                        return dto.toDomainModel()
                    }
                    let managedFavoritePlayers = footballPlayers.map { originalPlayer in
                        var player = originalPlayer
                        player.isFavorite = FavoritesManager.shared.favoritePlayers.contains { $0.playerId == player.playerId }
                        return player
                    }
                    
                    let sortedPlayers = sortPlayers(input: managedFavoritePlayers)
                    self.footballPlayersRelay.accept(sortedPlayers)
                    self.footballPlayersFilteredRelay.accept(sortedPlayers)
                    print("You have \(managedFavoritePlayers.count) football players")
                } catch {
                    print("Decoding error: \(error)")
                    self.errorRelay.accept(.decodingError)
                }
                completion?()
            }
        }.resume()
    }
    
    func overrideDataSourceBySearchBar(text: String) {
        print("Start overrideDataSourceBySearchBar")
        let lowerCasedText = text.lowercased()
        
        print("footballPlayers now are \(footballPlayersRelay.value.count)")
        let filteredPlayers = filterPlayersByText(input: footballPlayersRelay.value, text: text)
        print("filteredPlayers now are \(filteredPlayers.count)")
        let sortedPlayers = sortPlayers(input: filteredPlayers)
        print("sortedPlayer now are \(sortedPlayers.count)")
        footballPlayersFilteredRelay.accept(sortedPlayers)
    }

    func didTappedStarButton(footballPlayer: FootballPlayer) {
        print("didTappedStarButton with \(footballPlayer.playerName)")
        FavoritesManager.shared.managePlayer(footballPlayer: footballPlayer)
    }
}
