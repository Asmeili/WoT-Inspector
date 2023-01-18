//
//  ArmorDetailsViewController.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 07.12.22.
//

import UIKit
import WICoreUIKit

class ArmorDetailsViewController: WITableViewController, TabBarItem {
    static let title = "Armor Details"
    static let image = UIImage(systemName: "book.fill")
    
    override var viewModel: WITableViewModel? {
        get { return viewModel_ }
        set { }
    }
    var viewModel_: ArmorDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
