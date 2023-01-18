//
//  ProvisionsDetailsViewController.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 08.12.22.
//

import UIKit
import WICoreUIKit

class ProvisionsDetailsViewController: WITableViewController, TabBarItem {
    static let title = "Provisions Details"
    static let image = UIImage(systemName: "book.fill")
    
    override var viewModel: WITableViewModel? {
        get { return viewModel_ }
        set { }
    }
    var viewModel_: ProvisionsDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel_ else { return }
        setup(for: viewModel_)
    }
    
    private func setup(for viewModel: ProvisionsDetailsViewModel) {
        
    }
}
