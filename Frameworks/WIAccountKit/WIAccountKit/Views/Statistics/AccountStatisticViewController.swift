//
//  AccountStatisticViewController.swift
//  WIAccountKit
//
//  Created by Michael Artes on 04.12.22.
//

import Combine
import UIKit
import WICoreUIKit

class AccountStatisticViewController: WITableViewController, TabBarItem {
    static let title = "Account Statistic"
    static let image = UIImage(systemName: "chart.bar.fill")
    
    override var viewModel: WITableViewModel? {
        get { return viewModel_! }
        set { }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    var viewModel_: AccountStatisticViewModel?
    func setup() {
        title = "\(viewModel_?.statisticCategory ?? "Account") Statistic"
    }
}
