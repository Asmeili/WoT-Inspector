//
//  AmmoDetailsViewController.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 07.12.22.
//

import UIKit
import WICoreUIKit

class AmmoDetailsViewController: WITableViewController, TabBarItem {
    static let title = "Ammo Details"
    static let image = UIImage(systemName: "book.fill")
    
    override var viewModel: WITableViewModel? {
        get { return viewModel_ }
        set { }
    }
    var viewModel_: AmmoDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
