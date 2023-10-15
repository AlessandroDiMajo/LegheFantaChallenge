//
//  filterPlayersByText.swift
//  LegheFantaChallenge
//
//  Created by Alessandro Di Majo on 14/10/23.
//

import Foundation

func filterPlayersByText(input: [FootballPlayer], text: String) -> [FootballPlayer] {
    if text.isEmpty {
        return input
    } else {
        let textToSearch = text.lowercased()
        let filteredResult = input.filter { player in
            let playerName = player.playerName.lowercased()
            return playerName.contains(textToSearch)
        }
        return filteredResult
    }
}
