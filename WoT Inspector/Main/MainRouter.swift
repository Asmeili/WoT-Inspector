//
//  MainRouter.swift
//  WoT Inspector
//
//  Created by Michael Artes on 03.12.22.
//

import UIKit
import WIAccountKit
import WICrewKit
import WICoreKit
import WICoreUIKit
import WIMapsKit
import WITankopediaKit
import WIWargamingIDKit

enum MainRouter {

    // MARK: Services

    static let apiService = ApiService(applicationId: "<enter-application-id>", session: .shared)
    static func setup() {
        WIWargamingIDKit.setApiService(apiService)
        WIAccountKit.setApiService(apiService)
        WITankopediaKit.setApiService(apiService)
        WIMapsKit.setApiService(apiService)
        WICrewKit.setApiService(apiService)
    }
    
    // MARK: Home
    
    static func instantiateHomeViewController() -> HomeViewController {
        let storyboard = UIStoryboard(name: "HomeView", bundle: Bundle.main)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        return TabBarFactory.viewController(from: homeViewController)
    }
    
    // MARK: TabBar
    
    static func instantiateMainTabBarController() -> MainTabBarController {
        MainTabBarController()
    }
}
