//
//  HomeViewController.swift
//  WoT Inspector
//
//  Created by Michael Artes on 03.12.22.
//

import UIKit
import WICoreUIKit
import WIWargamingIDKit

class HomeViewController: UITableViewController, TabBarItem {
    static let title = "Home"
    static let image = UIImage(systemName: "house.fill")
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(WargamingIDHomeCell.nib, forCellReuseIdentifier: WargamingIDHomeCell.nibName)
    }
}
