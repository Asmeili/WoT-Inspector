//
//  WITableViewController.swift
//  WICoreUIKit
//
//  Created by Michael Artes on 04.12.22.
//

import Combine
import UIKit

open class WITableViewController: UITableViewController {
    private var subscribers = Set<AnyCancellable>()
    open var viewModel: WITableViewModel?
    
    open override func viewDidLoad() {
        tableView.backgroundColor = .systemGroupedBackground
        
        guard let viewModel else { fatalError("Must provide viewModel before viewDidLoad!") }
        viewModel.setup()
        viewModel.generateSections()
        setup(for: viewModel)
    }
    
    func setup(for viewModel: WITableViewModel) {
        subscribers.removeAll()
        viewModel.updateUI
            .receive(on: DispatchQueue.main)
            .sink { doReload in
                if doReload {
                    self.viewModel?.generateSections()
                    self.tableView.reloadData()
                }
            }
            .store(in: &subscribers)
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel else { fatalError("Must provide viewModel before viewDidLoad!") }
        let delegateSection = viewModel.sections[indexPath.section]
        let delegateCell = delegateSection.cells[indexPath.row]
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "WITableViewCell")
        var content = cell.defaultContentConfiguration()
        
        content.text = delegateCell.name
        content.secondaryText = delegateCell.value
        
        cell.contentConfiguration = content
        cell.accessoryType = delegateCell.accessoryType
        
        return cell
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel else { fatalError("Must provide viewModel before viewDidLoad!") }
        let delegateSection = viewModel.sections[section]
        return delegateSection.cells.count
    }
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel else { fatalError("Must provide viewModel before viewDidLoad!") }
        let delegateSection = viewModel.sections[indexPath.section]
        let delegateCell = delegateSection.cells[indexPath.row]

        if let action = delegateCell.action {
            action(self)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    open override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let viewModel else { fatalError("Must provide viewModel before viewDidLoad!") }
        let delegateSection = viewModel.sections[section]
        return delegateSection.title
    }
    
    open override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        guard let viewModel else { fatalError("Must provide viewModel before viewDidLoad!") }
        let delegateSection = viewModel.sections[section]
        return delegateSection.footer
    }
    
    open override func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel else { fatalError("Must provide viewModel before viewDidLoad!") }
        return viewModel.sections.count
    }
}
