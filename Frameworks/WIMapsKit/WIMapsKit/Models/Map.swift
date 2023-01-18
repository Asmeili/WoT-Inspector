//
//  Map.swift
//  WIMapsKit
//
//  Created by Michael Artes on 07.12.22.
//

enum CamouflageType: String, Codable {
    case summer
    case winter
    case desert
}

struct Map: Codable {
    let arenaId: String
    let camouflageType: CamouflageType
    let description: String
    let nameI18n: String?
    
    enum CodingKeys: String, CodingKey {
        case arenaId
        case camouflageType
        case description
        case nameI18n = "name_i18n"
    }
}
