//
//  AccountStatisticViewModel.swift
//  WIAccountKit
//
//  Created by Michael Artes on 04.12.22.
//

import Combine
import UIKit
import WICoreUIKit

final class AccountStatisticViewModel: WITableViewModel {
    private let accountService: AccountService
    let accountStatistic: AccountDetailsStatistic
    let statisticCategory: String
    init(_ accountService: AccountService, for accountStatistic: AccountDetailsStatistic, in statisticCategory: String) {
        self.accountService = accountService
        self.accountStatistic = accountStatistic
        self.statisticCategory = statisticCategory
    }
    
    func setup() { }
    
    var updateUI = PassthroughSubject<Bool, Never>()
    var sections = [Section]()
    func generateSections() {
        sections = [
            Section(title: "Profile", footer: nil, cells: [
                Cell(name: "Wins", value: String(accountStatistic.wins), accessoryType: .none, action: nil),
                Cell(name: "Draws", value: String(accountStatistic.draws), accessoryType: .none, action: nil),
                Cell(name: "Losses", value: String(accountStatistic.losses), accessoryType: .none, action: nil),
                Cell(name: "XP", value: String(accountStatistic.xp), accessoryType: .none, action: nil),
            ]),
            Section(title: "Avgs", footer: nil, cells: [
                Cell(name: "Avg Damage Assisted", value: String(accountStatistic.avgDamageAssisted ?? 0), accessoryType: .none, action: nil),
                Cell(name: "Avg Damage Assisted Radio", value: String(accountStatistic.avgDamageAssistedRadio ?? 0), accessoryType: .none, action: nil),
                Cell(name: "Avg Damage Assisted Track", value: String(accountStatistic.avgDamageAssistedTrack ?? 0), accessoryType: .none, action: nil),
                Cell(name: "Avg Damage Blocked", value: String(accountStatistic.avgDamageBlocked ?? 0), accessoryType: .none, action: nil),
                Cell(name: "Battle Avg Xp", value: String(accountStatistic.battleAvgXp), accessoryType: .none, action: nil)
            ]),
            Section(title: "Battles", footer: nil, cells: [
                Cell(name: "Battles", value: String(accountStatistic.battles), accessoryType: .none, action: nil),
                Cell(name: "Battles on Stunning Vehicles", value: String(accountStatistic.battlesOnStunningVehicles), accessoryType: .none, action: nil)
            ]),
            Section(title: "Capture Points", footer: nil, cells: [
                Cell(name: "Capture Points", value: String(accountStatistic.capturePoints), accessoryType: .none, action: nil),
                Cell(name: "Dropped Capture Points", value: String(accountStatistic.droppedCapturePoints), accessoryType: .none, action: nil)
            ]),
            Section(title: "Damages", footer: nil, cells: [
                Cell(name: "Damage Dealt", value: String(accountStatistic.damageDealt), accessoryType: .none, action: nil),
                Cell(name: "Damage Received", value: String(accountStatistic.damageReceived), accessoryType: .none, action: nil),
                Cell(name: "Direct Hits Received", value: String(accountStatistic.directHitsReceived), accessoryType: .none, action: nil),
                Cell(name: "No Damage Direct Hits Received", value: String(accountStatistic.noDamageDirectHitsReceived), accessoryType: .none, action: nil),
                Cell(name: "Explosion Hits", value: String(accountStatistic.explosionHits), accessoryType: .none, action: nil),
                Cell(name: "Explosion Hits Received", value: String(accountStatistic.explosionHitsReceived), accessoryType: .none, action: nil),
                Cell(name: "Frags", value: String(accountStatistic.frags), accessoryType: .none, action: nil),
                Cell(name: "Hits", value: String(accountStatistic.hits), accessoryType: .none, action: nil),
                Cell(name: "Hits Percent", value: "\(accountStatistic.hitsPercents)%", accessoryType: .none, action: nil),
                Cell(name: "Piercings", value: String(accountStatistic.piercings), accessoryType: .none, action: nil),
                Cell(name: "Piercings Received", value: String(accountStatistic.piercingsReceived), accessoryType: .none, action: nil),
            ]),
            Section(title: "Other", footer: nil, cells: [
                Cell(name: "Shots", value: String(accountStatistic.shots), accessoryType: .none, action: nil),
                Cell(name: "Spotted", value: String(accountStatistic.spotted), accessoryType: .none, action: nil),
                Cell(name: "Stun Assisted Damage", value: String(accountStatistic.stunAssistedDamage), accessoryType: .none, action: nil),
                Cell(name: "Stun Number", value: String(accountStatistic.stunNumber), accessoryType: .none, action: nil),
                Cell(name: "Survived Battles", value: String(accountStatistic.survivedBattles), accessoryType: .none, action: nil),
                Cell(name: "Tanking Factor", value: String(accountStatistic.tankingFactor), accessoryType: .none, action: nil)
            ])
        ]
        
        if let maxDamage = accountStatistic.maxDamage,
           let maxFrags = accountStatistic.maxFrags,
           let maxXp = accountStatistic.maxXp {
            sections.append(Section(title: "Max", footer: nil, cells: [
                Cell(name: "Max Damage", value: String(maxDamage), accessoryType: .none, action: nil),
                Cell(name: "Max Frags", value: String(maxFrags), accessoryType: .none, action: nil),
                Cell(name: "Max Xp", value: String(maxXp), accessoryType: .none, action: nil),
            ]))
        }
    }
}
