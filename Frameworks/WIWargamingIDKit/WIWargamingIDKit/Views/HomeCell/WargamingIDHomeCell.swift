//
//  WargamingIDHomeCell.swift
//  WIWargamingIDKit
//
//  Created by Michael Artes on 03.12.22.
//

import Combine
import UIKit
import WIAccountKit
import WICoreUIKit

public class WargamingIDHomeCell: UITableViewCell, Reusable {
    private var subscribers = Set<AnyCancellable>()
    public var viewModel: WargamingIDHomeCellViewModel?
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var iconView: UIImageView!
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var subtitle: UILabel!
    
    public func setup(for viewModel: WargamingIDHomeCellViewModel) {
        accessoryType = .disclosureIndicator
        self.viewModel = viewModel
        
        viewModel.isLoadingWargamingID
            .receive(on: DispatchQueue.main)
            .sink { isLoading in
                self.activityIndicator.isHidden = !isLoading
                self.iconView.isHidden = isLoading
                self.title.isHidden = isLoading
                self.subtitle.isHidden = isLoading
                if isLoading {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
            .store(in: &subscribers)
        viewModel.wargamingID
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    self.title.text = "Wargaming ID"
                    self.subtitle.text = "Error"
                }
            } receiveValue: { wargamingID in
                guard let wargamingID else {
                    self.title.text = "Wargaming ID"
                    self.subtitle.text = "Connect"
                    return
                }
                self.title.text = wargamingID.nickname
                self.subtitle.text = "See details"
            }
            .store(in: &subscribers)
    }
    
    public func didTap() {
        guard let viewModel,
              let tableView = self.tableView,
              let parentViewController = tableView.parentViewController
        else {
            return
        }

        if viewModel.shouldAuthenticate {
            let authenticateViewModel = WIWargamingIDKit.instantiateAuthenticateViewModel()
            let authenticateViewController = WIWargamingIDKit.instantiateAuthenticateViewController(with: authenticateViewModel)
            parentViewController.present(authenticateViewController, animated: true)
        } else {
            guard let wargamingID = viewModel.wargamingID.value else { return }
            let accountDetailsViewModel = WIAccountKit.instantiateAccountDetailsViewModel(for: wargamingID)
            let accountDetailsViewController = WIAccountKit.instantiateAccountDetailsViewController(with: accountDetailsViewModel)
            parentViewController.navigationController?.pushViewController(accountDetailsViewController, animated: true)
        }
    }
}
