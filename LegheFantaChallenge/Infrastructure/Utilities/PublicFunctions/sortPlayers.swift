//
//  sortPlayers.swift
//  LegheFantaChallenge
//
//  Created by Alessandro Di Majo on 14/10/23.
//

import Foundation

func sortPlayers(input: [FootballPlayer]) -> [FootballPlayer] {
    return input.sorted { (player1, player2) in
        if player1.teamAbbreviation != player2.teamAbbreviation {
            return player1.teamAbbreviation < player2.teamAbbreviation
        } else {
            return player1.playerName < player2.playerName
        }
    }
}
