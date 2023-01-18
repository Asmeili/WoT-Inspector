//
//  AccountsSearchViewController.swift
//  WIAccountKit
//
//  Created by Michael Artes on 04.12.22.
//

import Combine
import UIKit
import WICoreUIKit

public class AccountSearchViewController: UITableViewController, TabBarItem {
    public static let title = "Search"
    public static let image = UIImage(systemName: "magnifyingglass")
    
    private let searchController = UISearchController()
    
    private var subscribers = Set<AnyCancellable>()
    var viewModel: AccountSearchViewModel?
    
    public override func viewDidLoad() {
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        guard let viewModel else { return }
        viewModel.setup()
        setup(for: viewModel)
    }
    
    private func setup(for viewModel: AccountSearchViewModel) {
        subscribers.removeAll()
        viewModel.accounts
            .receive(on: DispatchQueue.main)
            .sink { completion in
                
            } receiveValue: { _ in
                self.tableView.reloadData()
            }
            .store(in: &subscribers)
    }
}
