//
//  SiegeDetailsViewController.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 07.12.22.
//

import UIKit
import WICoreUIKit

class SiegeDetailsViewController: WITableViewController, TabBarItem {
    static let title = "Siege Details"
    static let image = UIImage(systemName: "book.fill")
    
    override var viewModel: WITableViewModel? {
        get { return viewModel_ }
        set { }
    }
    var viewModel_: SiegeDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel_ else { return }
        setup(for: viewModel_)
    }
    
    private func setup(for viewModel: SiegeDetailsViewModel) {
        
    }
}
