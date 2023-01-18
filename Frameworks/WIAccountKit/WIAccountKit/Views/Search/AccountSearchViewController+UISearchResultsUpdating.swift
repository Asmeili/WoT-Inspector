//
//  AccountSearchViewController+UISearchResultsUpdating.swift
//  WIAccountKit
//
//  Created by Michael Artes on 04.12.22.
//

import UIKit

extension AccountSearchViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        viewModel?.searchText.send(text)
    }
}
