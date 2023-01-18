//
//  AccountDetails.swift
//  WIAccountKit
//
//  Created by Michael Artes on 03.12.22.
//

import Foundation

public struct AccountDetailsStatistic: Codable {
    public let avgDamageAssisted: Float?
    public let avgDamageAssistedRadio: Float?
    public let avgDamageAssistedTrack: Float?
    public let avgDamageBlocked: Float?
    public let battleAvgXp: Int
    public let battles: Int
    public let battlesOnStunningVehicles: Int
    public let capturePoints: Int
    public let damageDealt: Int
    public let damageReceived: Int
    public let directHitsReceived: Int
    public let draws: Int
    public let droppedCapturePoints: Int
    public let explosionHits: Int
    public let explosionHitsReceived: Int
    public let frags: Int
    public let hits: Int
    public let hitsPercents: Int
    public let losses: Int
    public let maxDamage: Int?
    public let maxDamageTankId: Int?            //
    public let maxFrags: Int?
    public let maxFragsTankId: Int?             //
    public let maxXp: Int?
    public let maxXpTankId: Int?                //
    public let noDamageDirectHitsReceived: Int
    public let piercings: Int
    public let piercingsReceived: Int
    public let shots: Int
    public let spotted: Int
    public let stunAssistedDamage: Int
    public let stunNumber: Int
    public let survivedBattles: Int
    public let tankingFactor: Float
    public let wins: Int
    public let xp: Int
}

public struct AccountDetailsStatistics: Codable {
    public let all: AccountDetailsStatistic
    public let clan: AccountDetailsStatistic
    public let company: AccountDetailsStatistic
    public let frags: [Int: Int]?
    public let historical: AccountDetailsStatistic
    public let regularTeam: AccountDetailsStatistic
    public let strongholdDefense: AccountDetailsStatistic
    public let strongholdSkirmish: AccountDetailsStatistic
    public let team: AccountDetailsStatistic
    public let treesCut: Int
}

public struct AccountDetailsPrivateRestricitions: Codable {
    public let chatBanTime: Int?
}

public struct AccountDetailsPrivate: Codable {
    public let banInfo: String?
    public let banTime: Int?
    public let battleLifeTime: Int
    public let bonds: Int
    public let credits: Int
    public let freeXp: Int
    public let gold: Int
    public let isBoundToPhone: Bool
    public let isPremium: Bool
    public let premiumExpiresAt: Int
    public let restrictions: AccountDetailsPrivateRestricitions
}

public struct AccountDetails: Codable {
    public let accountId: Int //
    public let clanId: Int?
    public let clientLanguage: String
    public let createdAt: Int //
    public let globalRating: Int //
    public let lastBattleTime: Int //
    public let logoutAt: Int //
    public let nickname: String //
    public let `private`: AccountDetailsPrivate?
    public let statistics: AccountDetailsStatistics
    public let updatedAt: Int //
}
