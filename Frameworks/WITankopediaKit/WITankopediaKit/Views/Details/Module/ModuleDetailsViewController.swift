//
//  ModuleDetailsViewController.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 07.12.22.
//

import UIKit
import WICoreUIKit

class ModuleDetailsViewController: WITableViewController, TabBarItem {
    static let title = "Module Details"
    static let image = UIImage(systemName: "book.fill")
    
    override var viewModel: WITableViewModel? {
        get { return viewModel_ }
        set { }
    }
    var viewModel_: ModuleDetailsViewModel?
    
    override func viewDidLoad() {
        tableView.register(DetailsIconCell.nib, forCellReuseIdentifier: DetailsIconCell.nibName)
        
        super.viewDidLoad()
        guard let viewModel_ else { return }
        setup(for: viewModel_)
    }
    
    private func setup(for viewModel: ModuleDetailsViewModel) {
        title = "\(viewModel.module.name) Details"
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let viewModel_ else { fatalError("Must provide ViewModel!") }
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailsIconCell.nibName, for: indexPath) as! DetailsIconCell
            cell.setup(for: viewModel_.module.image)
            return cell
        default:
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
}
