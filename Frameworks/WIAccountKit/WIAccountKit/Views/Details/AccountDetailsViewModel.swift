//
//  AccountDetailsViewModel.swift
//  WIAccountKit
//
//  Created by Michael Artes on 04.12.22.
//

import Combine
import UIKit
import WICoreUIKit

public final class AccountDetailsViewModel: WITableViewModel {
    let accountService: AccountService
    let account: Account
    init(_ accountService: AccountService, for account: Account) {
        self.accountService = accountService
        self.account = account
    }
    
    init(_ accountService: AccountService, for accountDetails: AccountDetails) {
        self.accountService = accountService
        self.account = Account(accountId: accountDetails.accountId, nickname: accountDetails.nickname)
        self.accountDetails.send(accountDetails)
    }
    
    let accountDetails = CurrentValueSubject<AccountDetails?, Error>(nil)
    public var updateUI = PassthroughSubject<Bool, Never>()
    
    private var subscribers = Set<AnyCancellable>()
    public func setup() {
        generateSections()
        if accountDetails.value == nil {
            accountService.details(for: account.accountId)
                .sink { completion in
                    self.accountDetails.send(completion: completion)
                } receiveValue: { accountDetails in
                    self.accountDetails.send(accountDetails)
                }
                .store(in: &subscribers)
        }
    }
    
    public var sections = [Section]()
    public func generateSections() {
        guard let accountDetails = accountDetails.value else {
            sections = []
            return
        }
        
        let openStatistic = { (statistic: AccountDetailsStatistic, category: String, viewController: UIViewController) in
            let accountStatisticViewModel = WIAccountKit.instantiateAccountStatisticViewModel(for: statistic, in: category)
            let accountStatisticViewController = WIAccountKit.instantiateAccountStatisticViewController(with: accountStatisticViewModel)
            viewController.navigationController?.pushViewController(accountStatisticViewController, animated: true)
        }
        
        sections = [
            Section(title: "Account Details", footer: nil, cells: [
                Cell(name: "Account ID", value: String(accountDetails.accountId), accessoryType: .none, action: nil),
                Cell(name: "Clan ID", value: String(accountDetails.clanId ?? 0), accessoryType: .none, action: nil),
                Cell(name: "Nickname", value: accountDetails.nickname, accessoryType: .none, action: nil),
                Cell(name: "Global Rating", value: String(accountDetails.globalRating), accessoryType: .none, action: nil),
                Cell(name: "Last Battle", value: accountDetails.lastBattleTime.asDate, accessoryType: .none, action: nil),
                Cell(name: "Logout At", value: accountDetails.logoutAt.asDate, accessoryType: .none, action: nil),
                Cell(name: "Created At", value: accountDetails.createdAt.asDate, accessoryType: .none, action: nil),
                Cell(name: "Updated At", value: accountDetails.updatedAt.asDate, accessoryType: .none, action: nil)
            ]),
            Section(title: "Statistics", footer: nil, cells: [
                Cell(name: "Trees Cut", value: String(accountDetails.statistics.treesCut), accessoryType: .none, action: nil),
                Cell(name: "All", value: nil, accessoryType: .disclosureIndicator) { viewController in
                    openStatistic(accountDetails.statistics.all, "All", viewController)
                },
                Cell(name: "Clan", value: nil, accessoryType: .disclosureIndicator) { viewController in
                    openStatistic(accountDetails.statistics.clan, "Clan", viewController)
                },
                Cell(name: "Company", value: nil, accessoryType: .disclosureIndicator) { viewController in
                    openStatistic(accountDetails.statistics.company, "Company", viewController)
                },
                Cell(name: "Historical", value: nil, accessoryType: .disclosureIndicator) { viewController in
                    openStatistic(accountDetails.statistics.historical, "Historical", viewController)
                },
                Cell(name: "Regular Team", value: nil, accessoryType: .disclosureIndicator) { viewController in
                    openStatistic(accountDetails.statistics.regularTeam, "Regular Team", viewController)
                },
                Cell(name: "Stronghold Defense", value: nil, accessoryType: .disclosureIndicator) { viewController in
                    openStatistic(accountDetails.statistics.strongholdDefense, "Stronghold Defense", viewController)
                },
                Cell(name: "Stronghold Skirmish", value: nil, accessoryType: .disclosureIndicator) { viewController in
                    openStatistic(accountDetails.statistics.strongholdSkirmish, "Stronghold Skirmish", viewController)
                },
                Cell(name: "Team", value: nil, accessoryType: .disclosureIndicator) { viewController in
                    openStatistic(accountDetails.statistics.team, "Team", viewController)
                }
            ])
        ]
    }
}
