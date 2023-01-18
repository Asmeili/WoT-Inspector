//
//  AccountDetailsViewController.swift
//  WIAccountKit
//
//  Created by Michael Artes on 04.12.22.
//

import Combine
import UIKit
import WICoreUIKit

public class AccountDetailsViewController: WITableViewController, TabBarItem {
    public static let title = "Account Details"
    public static let image = UIImage(systemName: "person")
    
    private var subscribers = Set<AnyCancellable>()
    public override var viewModel: WITableViewModel? {
        get { return viewModel_ }
        set { }
    }
    var viewModel_: AccountDetailsViewModel?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        guard let viewModel_ else { return }
        setup(for: viewModel_)
    }
    
    private func setup(for viewModel: AccountDetailsViewModel) {
        title = viewModel.account.nickname
        subscribers.removeAll()
        viewModel.accountDetails
            .receive(on: DispatchQueue.main)
            .sink { completion in
                
            } receiveValue: { _ in
                self.viewModel_?.updateUI.send(true)
            }
            .store(in: &subscribers)
    }
}
