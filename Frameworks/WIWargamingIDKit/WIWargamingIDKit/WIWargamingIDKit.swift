//
//  WIWargamingIDKit.swift
//  WIWargamingIDKit
//
//  Created by Michael Artes on 03.12.22.
//

import Combine
import UIKit
import WICoreKit
import WICoreUIKit

public enum WIWargamingIDKit {

    // MARK: Services

    private static var apiService: ApiService!
    public static var authenticateService: AuthenticateService!
    public static func setApiService(_ apiService: ApiService) {
        self.apiService = apiService
        self.authenticateService = AuthenticateService(apiService)
    }
    
    // MARK: Authenticate
    
    public static func instantiateAuthenticateViewModel() -> AuthenticateViewModel {
        AuthenticateViewModel(authenticateService)
    }
    
    public static func instantiateAuthenticateViewController(with viewModel: AuthenticateViewModel) -> AuthenticateViewController {
        let storyboard = UIStoryboard(name: "AuthenticateView", bundle: Bundle(for: AuthenticateViewController.self))
        let authenticateViewController = storyboard.instantiateViewController(withIdentifier: "AuthenticateViewController") as! AuthenticateViewController
        authenticateViewController.viewModel = viewModel
        return TabBarFactory.viewController(from: authenticateViewController)
    }
    
    // MARK: HomeCell
    
    public static func instantiateWargamingIDHomeCellViewModel() -> WargamingIDHomeCellViewModel {
        WargamingIDHomeCellViewModel(authenticateService)
    }
}
