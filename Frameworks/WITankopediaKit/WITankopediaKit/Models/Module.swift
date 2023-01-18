//
//  Module.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 07.12.22.
//

public enum ModuleType: String, Codable {
    case vehicleEngine
    case vehicleGun
    case vehicleRadio
    case vehicleChassis
    case vehicleTurret
    
    func readable() -> String {
        switch self {
        case .vehicleEngine:
            return "Engine"
        case .vehicleGun:
            return "Gun"
        case .vehicleRadio:
            return "Radio"
        case .vehicleChassis:
            return "Suspension"
        case .vehicleTurret:
            return "Turret"
        }
    }
}

public struct ModuleSuspension: Hashable, Codable {
    public let loadLimit: Int
    public let traverseSpeed: Int
}

public struct ModuleTurret: Hashable, Codable {
    public let viewRange: Int
    public let hp: Int
    public let armorFront: Int
    public let traverseSpeed: Int
    public let armorRear: Int
    public let armorSides: Int
}

public struct ModuleRadio: Hashable, Codable {
    public let signalRange: Int
}

public struct ModuleEngine: Hashable, Codable {
    public let fireChance: Float
    public let power: Int
}

public struct ModuleGun: Hashable, Codable {
    public let moveDownArc: Int
    public let maxAmmo: Int
    public let reloadTime: Float
    public let moveUpArc: Int
    public let fireRate: Float
    public let dispersion: Float
    public let traverseSpeed: Int
    public let aimTime: Float
    public let ammo: [VehicleAmmo]
}

public struct ModuleDefaultProfile: Hashable, Codable {
    let suspension: ModuleSuspension?
    let turret: ModuleTurret?
    let radio: ModuleRadio?
    let gun: ModuleGun?
    let engine: ModuleEngine?
}

public struct Module: Hashable, Codable {
    public let name: String
    public let tier: Int
    public let weight: Int
    public let image: String
    public let nation: VehicleNationInternal
    public let priceCredit: Int
    public let tanks: [Int]
    public let moduleId: Int
    public let type: ModuleType
    public let defaultProfile: ModuleDefaultProfile?
}
