//
//  AccountSearchViewController+UITableViewDelegate.swift
//  WIAccountKit
//
//  Created by Michael Artes on 04.12.22.
//

import UIKit

public extension AccountSearchViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let viewModel,
              viewModel.accounts.value.count > 0
        else { return }
        
        let accounts = viewModel.accounts.value
        let account = accounts[indexPath.row]
        let accountDetailsViewModel = WIAccountKit.instantiateAccountDetailsViewModel(for: account)
        let accountDetailsViewController = WIAccountKit.instantiateAccountDetailsViewController(with: accountDetailsViewModel)
        navigationController?.pushViewController(accountDetailsViewController, animated: true)
    }
}
