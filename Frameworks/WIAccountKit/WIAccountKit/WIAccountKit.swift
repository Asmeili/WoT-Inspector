//
//  WIAccountKit.swift
//  WIAccountKit
//
//  Created by Michael Artes on 03.12.22.
//

import UIKit
import WICoreKit
import WICoreUIKit

public enum WIAccountKit {
    
    // MARK: Services
    
    private static var apiService: ApiService!
    public static var accountService: AccountService!
    public static func setApiService(_ apiService: ApiService) {
        self.apiService = apiService
        self.accountService = AccountService(apiService)
    }
    
    // MARK: Account Details
    
    public static func instantiateAccountDetailsViewModel(for account: Account) -> AccountDetailsViewModel {
        AccountDetailsViewModel(accountService, for: account)
    }
    
    public static func instantiateAccountDetailsViewModel(for accountDetails: AccountDetails) -> AccountDetailsViewModel {
        AccountDetailsViewModel(accountService, for: accountDetails)
    }
    
    public static func instantiateAccountDetailsViewController(with viewModel: AccountDetailsViewModel) -> AccountDetailsViewController {
        let storyboard = UIStoryboard(name: "AccountDetailsView", bundle: Bundle(for: AccountDetailsViewController.self))
        let accountDetailsViewController = storyboard.instantiateViewController(withIdentifier: "AccountDetailsViewController") as! AccountDetailsViewController
        accountDetailsViewController.viewModel_ = viewModel
        return TabBarFactory.viewController(from: accountDetailsViewController)
    }
    
    // MARK: Account Search
    
    public static func instantiateAccountSearchViewModel() -> AccountSearchViewModel {
        AccountSearchViewModel(accountService)
    }
    
    public static func instantiateAccountSearchViewController(with viewModel: AccountSearchViewModel) -> AccountSearchViewController {
        let storyboard = UIStoryboard(name: "AccountSearchView", bundle: Bundle(for: AccountSearchViewController.self))
        let accountSearchViewController = storyboard.instantiateViewController(withIdentifier: "AccountSearchViewController") as! AccountSearchViewController
        accountSearchViewController.viewModel = viewModel
        return TabBarFactory.viewController(from: accountSearchViewController)
    }
    
    // MARK: Account Statistic
    
    static func instantiateAccountStatisticViewModel(for accountStatistic: AccountDetailsStatistic, in statisticCategory: String) -> AccountStatisticViewModel {
        AccountStatisticViewModel(accountService, for: accountStatistic, in: statisticCategory)
    }
    
    static func instantiateAccountStatisticViewController(with viewModel: AccountStatisticViewModel) -> AccountStatisticViewController {
        let storyboard = UIStoryboard(name: "AccountStatisticView", bundle: Bundle(for: AccountStatisticViewController.self))
        let accountStatisticViewController = storyboard.instantiateViewController(withIdentifier: "AccountStatisticViewController") as! AccountStatisticViewController
        accountStatisticViewController.viewModel_ = viewModel
        return TabBarFactory.viewController(from: accountStatisticViewController)
    }
}
