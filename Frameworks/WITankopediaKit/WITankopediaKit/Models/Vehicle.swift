//
//  Vehicle.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 04.12.22.
//

public struct VehicleImages: Hashable, Codable {
    public let smallIcon: String
    public let contourIcon: String
    public let bigIcon: String
}

public struct VehicleCrew: Hashable, Codable {
    public let roles: [String: CrewRole]
    public let memberId: String
}

public struct VehicleTreeModule: Hashable, Codable {
    public let name: String?
    public let nextModules: [Int]?
    public let nextTanks: [Int]?
    public let isDefault: Bool
    public let priceXp: Int
    public let priceCredit: Int
    public let moduleId: Int
    public let type: String
}

public struct VehicleEngine: Hashable, Codable {
    public let name: String?
    public let power: Int
    public let weight: Int
    public let tag: String
    public let fireChance: Float
    public let tier: Int
}

public struct VehicleSuspension: Hashable, Codable {
    public let name: String
    public let weight: Int
    public let loadLimit: Int
    public let tag: String
    public let traverseSpeed: Int
    public let tier: Int
    public let steeringLockAngle: Int
}

public struct VehicleArmor: Hashable, Codable {
    public let turret: VehicleModuleArmor?
    public let hull: VehicleModuleArmor
}

public struct VehicleModuleArmor: Hashable, Codable {
    public let front: Int
    public let sides: Int
    public let rear: Int
}

public struct VehicleModules: Hashable, Codable {
    public let gunId: Int
    public let suspensionId: Int
    public let turretId: Int?
    public let radioId: Int
    public let engineId: Int
}

public struct VehicleGun: Hashable, Codable {
    public let moveDownArc: Int
    public let caliber: Int
    public let name: String
    public let weight: Int
    public let moveUpArc: Int
    public let fireRate: Float
    public let dispersion: Float
    public let tag: String
    public let traverseSpeed: Int
    public let reloadTime: Float
    public let tier: Int
    public let aimTime: Float
}

public struct VehicleRapid: Hashable, Codable {
    public let speedBackward: Float
    public let switchOffTime: Float
    public let switchOnTime: Float
    public let speedForward: Float
    public let suspensionSteeringLockAngle: Float
}

public struct VehicleTurret: Hashable, Codable {
    public let name: String
    public let weight: Int
    public let viewRange: Int
    public let hp: Int
    public let tag: String
    public let traverseSpeed: Int?
    public let traverseRightArc: Int?
    public let tier: Int
    public let traverseLeftArc: Int?
}

public struct VehicleRadio: Hashable, Codable {
    public let tier: Int
    public let signalRange: Int
    public let tag: String
    public let name: String?
    public let weight: Int
}

public struct VehicleAmmoStun: Hashable, Codable {
    let duration: [Float]
}

public struct VehicleAmmo: Hashable, Codable {
    public let penetration: [Int]
    public let stun: VehicleAmmoStun?
    public let type: String
    public let damage: [Int]
}

public struct VehicleSiege: Hashable, Codable {
    public let suspensionTraverseSpeed: Float
    public let moveDownArc: Float
    public let switchOnTime: Float
    public let reloadTime: Float
    public let moveUpArc: Float
    public let dispersion: Float
    public let switchOffTime: Float
    public let speedBackward: Float
    public let aimTime: Float
}

public struct VehicleDefaultProfile: Hashable, Codable {
    public let engine: VehicleEngine
    public let siege: VehicleSiege?
    public let suspension: VehicleSuspension
    public let weight: Int
    public let armor: VehicleArmor
    public let hp: Int
    public let modules: VehicleModules
    public let gun: VehicleGun
    public let turret: VehicleTurret?
    public let hullWeight: Int
    public let radio: VehicleRadio
    public let rapid: VehicleRapid?
    public let speedForward: Int
    public let hullHp: Int
    public let speedBackward: Int
    public let ammo: [VehicleAmmo]
}

public struct Vehicle: Hashable, Codable {
    public let isWheeled: Bool
    public let radios: [Int]
    public let isPremium: Bool
    public let tag: String
    public let images: VehicleImages
    public let tankId: Int
    public let suspensions: [Int]
    public let provisions: [Int]
    public let engines: [Int]
    public let crew: [VehicleCrew]
    public let type: VehicleTypeInternal
    public let guns: [Int]
    public let multination: Bool?
    public let description: String
    public let shortName: String
    public let isPremiumIgr: Bool
    public let modulesTree: [String: VehicleTreeModule]?
    public let nation: VehicleNationInternal
    public let tier: Int
    public let pricesXp: [String: Int]?
    public let isGift: Bool
    public let name: String
    public let priceGold: Int?
    public let priceCredit: Int?
    public let defaultProfile: VehicleDefaultProfile
    public let turrets: [Int]?
}
