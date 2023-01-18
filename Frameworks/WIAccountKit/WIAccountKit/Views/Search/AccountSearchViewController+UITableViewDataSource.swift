//
//  AccountSearchViewController+UITableViewDataSource.swift
//  WIAccountKit
//
//  Created by Michael Artes on 04.12.22.
//

import UIKit

public extension AccountSearchViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel, viewModel.accounts.value.count > 0 else {
            let cell = UITableViewCell()
            var content = cell.defaultContentConfiguration()
            content.text = "No search results"
            cell.contentConfiguration = content
            return cell
        }
        
        let account = viewModel.accounts.value[indexPath.row]
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Kek")
        cell.accessoryType = .disclosureIndicator
        
        var content = cell.defaultContentConfiguration()
        content.text = account.nickname
        content.secondaryText = String(account.accountId)
        content.image = UIImage(systemName: "person.fill")
        
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel else { return 0 }
        guard viewModel.accounts.value.count > 1 else { return 1 }
        return viewModel.accounts.value.count
    }
}
