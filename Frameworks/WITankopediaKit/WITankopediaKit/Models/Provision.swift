//
//  Provision.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 08.12.22.
//

public enum ProvisionType: String, Codable {
    case equipment
    case optionalDevice
    
    func readable() -> String {
        switch self {
        case .equipment:
            return "Equipment"
        case .optionalDevice:
            return "Optional Device"
        }
    }
}

public struct Provision: Codable {
    public let name: String
    public let priceGold: Int
    public let image: String
    public let tag: String
    public let weight: Int?
    public let provisionId: Int
    public let priceCredit: Int
    public let type: ProvisionType
    public let description: String?
}
