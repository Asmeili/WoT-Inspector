//
//  TabBarFactory.swift
//  WICoreUIKit
//
//  Created by Michael Artes on 03.12.22.
//

import UIKit

public enum TabBarFactory {
    public static func viewController<T: UIViewController & TabBarItem>(from viewController: T) -> T {
        viewController.title = T.self.title
        viewController.tabBarItem.image = T.self.image
        return viewController
    }
    
    public static func navigationViewController<T: UIViewController & TabBarItem>(from viewController: T) -> UINavigationController {
        let tabBarViewControler = self.viewController(from: viewController)
        let navigationViewController = UINavigationController(rootViewController: tabBarViewControler)
        navigationViewController.title = T.self.title
        navigationViewController.tabBarItem.image = T.self.image
        navigationViewController.navigationBar.prefersLargeTitles = true
        return navigationViewController
    }
}
