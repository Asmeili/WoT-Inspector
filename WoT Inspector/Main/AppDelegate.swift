//
//  AppDelegate.swift
//  WoT Inspector
//
//  Created by Michael Artes on 03.12.22.
//

import UIKit
import WICoreKit
import WIWargamingIDKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
        
    // MARK: UIApplicationDelegate Lifecycle
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) { }
}
