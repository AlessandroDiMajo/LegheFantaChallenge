//
//  FavoritePlayersViewModel.swift
//  LegheFantaChallenge
//
//  Created by Alessandro Di Majo on 12/10/23.
//

import Foundation
import RxCocoa

class FavoritePlayersViewModel {
    
    let savedFootballPlayersRelay: BehaviorRelay<[FootballPlayer]> = BehaviorRelay<[FootballPlayer]>(value: [])
    
    init() {
        let storedFootballPlayer = UserDefaultsConfig.favoritePlayers ?? []
        savedFootballPlayersRelay.accept(storedFootballPlayer)
        NotificationCenter.default.addObserver(self, selector: #selector(favoritesUpdated), name: Notification.Name(Constants.Notifications.favoritesUpdated.rawValue), object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func favoritesUpdated() {
        let storedFootballPlayer = UserDefaultsConfig.favoritePlayers ?? []
        savedFootballPlayersRelay.accept(storedFootballPlayer)
    }
}
