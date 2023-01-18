//
//  AccountStatisticViewController.swift
//  WIAccountKit
//
//  Created by Michael Artes on 04.12.22.
//

import Combine
import UIKit

class AccountStatisticViewController: UITableViewController {
    private var subscribers = Set<AnyCancellable>()
    var viewModel: AccountStatisticViewModel?
    
    override func viewDidLoad() {
        guard let viewModel else { return }
        viewModel.setup()
        setup(for: viewModel)
    }
    
    func setup(for viewModel: AccountStatisticViewModel) {
        subscribers.removeAll()
        
    }
}
