//
//  TankopediaInformation.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 04.12.22.
//

public enum CrewRole: String, Codable {
    case loader = "Loader"
    case radioman = "Radio Operator"
    case driver = "Driver"
    case gunner = "Gunner"
    case commander = "Commander"
}

public enum TankopediaLanguage: String, Codable {
    case ru = "Русский"
    case fr = "Français"
    case en = "English"
    case zhTw = "繁體中文"
    case de = "Deutsch"
    case tr = "Türkçe"
    case ko = "한국어"
    case zhCn = "简体中文"
    case es = "Español"
    case th = "ไทย"
    case vi = "Tiếng Việt"
    case cs = "Čeština"
    case pl = "Polski"
}

public struct AchievementSection: Codable {
    public let name: String
    public let order: Int
}

public enum VehicleType: String, Codable {
    case heavyTank = "Heavy Tank"
    case atSPG = "Tank Destroyer"
    case mediumTank = "Medium Tank"
    case lightTank = "Light Tank"
    case spg = "SPG"
}

public enum VehicleTypeInternal: String, Codable {
    case heavyTank
    case atSPG = "AT-SPG"
    case mediumTank
    case lightTank
    case spg = "SPG"
    
    func readable() -> VehicleType {
        switch self {
        case .heavyTank:
            return .heavyTank
        case .atSPG:
            return .atSPG
        case .mediumTank:
            return .mediumTank
        case .lightTank:
            return .lightTank
        case .spg:
            return .spg
        }
    }
}

public enum VehicleNation: String, Codable, CaseIterable {
    case italy = "Italy"
    case usa = "U.S.A."
    case czech = "Czechoslovakia"
    case poland = "Poland"
    case france = "France"
    case sweden = "Sweden"
    case ussr = "U.S.S.R."
    case china = "China"
    case uk = "U.K."
    case japan = "Japan"
    case germany = "Germany"
}

public enum VehicleNationInternal: String, Codable {
    case italy
    case usa
    case czech
    case poland
    case france
    case sweden
    case ussr
    case china
    case uk
    case japan
    case germany
    
    func readable() -> VehicleNation {
        switch self {
        case .italy:
            return .italy
        case .usa:
            return .usa
        case .czech:
            return .czech
        case .poland:
            return .poland
        case .france:
            return .france
        case .sweden:
            return .sweden
        case .ussr:
            return .ussr
        case .china:
            return .china
        case .uk:
            return .uk
        case .japan:
            return .japan
        case .germany:
            return .germany
        }
    }
}

public struct TankopediaInformation: Codable {
    public let vehicleCrewRoles: [String: CrewRole]
    public let tanksUpdatedAt: Int
    public let languages: [String: TankopediaLanguage]
    public let achievementSections: [String: AchievementSection]
    public let vehicleTypes: [String: VehicleType]
    public let vehicleNations: [String: VehicleNation]
    public let gameVersion: String
}
