//
//  LegheFantaDTO.swift
//  LegheFantaChallenge
//
//  Created by Alessandro Di Majo on 13/10/23.
//

import Foundation

protocol LegheFantaDTO: Codable {
    associatedtype T
    func toDomainModel() -> T
}
