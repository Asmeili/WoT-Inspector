//
//  RadioDetailsViewController.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 07.12.22.
//

import UIKit
import WICoreUIKit

class RadioDetailsViewController: WITableViewController, TabBarItem {
    static let title = "Radio Details"
    static let image = UIImage(systemName: "book.fill")
    
    override var viewModel: WITableViewModel? {
        get { return viewModel_ }
        set { }
    }
    var viewModel_: RadioDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel_ else { return }
        setup(for: viewModel_)
    }
    
    private func setup(for viewModel: RadioDetailsViewModel) {
        if let name = viewModel.radio.name {
            title = "\(name) Details"
        }
    }
}
