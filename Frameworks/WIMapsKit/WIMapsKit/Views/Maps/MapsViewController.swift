//
//  MapsViewController.swift
//  WIMapsKit
//
//  Created by Michael Artes on 07.12.22.
//

import UIKit
import WICoreUIKit

public class MapsViewController: WITableViewController, TabBarItem {
    public static let title = "Maps"
    public static let image = UIImage(systemName: "map.fill")
    
    public override var viewModel: WITableViewModel? {
        get { return viewModel_ }
        set { }
    }
    var viewModel_: MapsViewModel?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel_ else { return }
        setup(for: viewModel_)
    }
    
    private func setup(for viewModel: MapsViewModel) {
        
    }
}
