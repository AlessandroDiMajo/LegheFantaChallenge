//
//  FootballPlayer.swift
//  LegheFantaChallenge
//
//  Created by Alessandro Di Majo on 13/10/23.
//

import Foundation

struct FootballPlayerDTO: LegheFantaDTO {
    let averageGrade: Double
    let teamAbbreviation: String
    let playerId: Int
    let playerName: String
    let imageURL: URL
    let averageFantaGrade: Double
    let gamesPlayed: Int
    
    func toDomainModel() -> FootballPlayer {
        .init(averageGrade: averageGrade,
              teamAbbreviation: teamAbbreviation,
              playerId: playerId,
              playerName: playerName,
              imageURL: imageURL,
              averageFantaGrade: averageGrade,
              gamesPlayed: gamesPlayed,
              isFavorite: false) // As defaults
    }
}

struct FootballPlayer: Codable { //Is Codable because without this Protocol we can not save this struct into UserDefaults
    let averageGrade: Double
    let teamAbbreviation: String
    let playerId: Int
    let playerName: String
    let imageURL: URL
    let averageFantaGrade: Double
    let gamesPlayed: Int
    var isFavorite: Bool
}
