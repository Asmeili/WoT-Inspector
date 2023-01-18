//
//  MainTabBarController.swift
//  WoT Inspector
//
//  Created by Michael Artes on 03.12.22.
//

import UIKit
import WIAccountKit
import WICoreUIKit
import WIMapsKit
import WITankopediaKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        createBlurEffect()
        
        let homeViewController = MainRouter.instantiateHomeViewController()
        
        let accountSearchViewModel = WIAccountKit.instantiateAccountSearchViewModel()
        let accountSearchViewController = WIAccountKit.instantiateAccountSearchViewController(with: accountSearchViewModel)
        
        let tankopediaDiscoverViewModel = WITankopediaKit.instantiateTankopediaDiscoverViewModel()
        let tankopediaDiscoverViewController = WITankopediaKit.instantiateTankopediaDiscoverViewController(with: tankopediaDiscoverViewModel)
        tankopediaDiscoverViewController.preload()
        
        let mapsViewModel = WIMapsKit.instantiateMapsViewModel()
        let mapsViewController = WIMapsKit.instantiateMapsViewController(with: mapsViewModel)
        
        setViewControllers([
            TabBarFactory.navigationViewController(from: homeViewController),
            TabBarFactory.navigationViewController(from: accountSearchViewController),
            TabBarFactory.navigationViewController(from: tankopediaDiscoverViewController),
            TabBarFactory.navigationViewController(from: mapsViewController)
        ], animated: false)
    }
    
    private func createBlurEffect() {
        let blurEffect = UIBlurEffect(style: .systemThinMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = tabBar.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tabBar.addSubview(blurEffectView)
    }
}
