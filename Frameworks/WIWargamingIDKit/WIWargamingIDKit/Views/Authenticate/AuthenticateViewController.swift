//
//  AuthenticateViewController.swift
//  WIWargamingIDKit
//
//  Created by Michael Artes on 03.12.22.
//

import Combine
import UIKit
import WebKit
import WICoreUIKit

public class AuthenticateViewController: UIViewController, TabBarItem {
    public static let title = "Authenticate"
    public static let image = UIImage(systemName: "house")
    
    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private var subscribers = Set<AnyCancellable>()
    var viewModel: AuthenticateViewModel?
    
    public override func viewDidLoad() {
        activityIndicator.layer.zPosition = webView.layer.zPosition + 1
        activityIndicator.color = .black
        webView.navigationDelegate = self
        
        guard let viewModel else { return }
        viewModel.setup()
        setup(for: viewModel)
    }
    
    func setup(for viewModel: AuthenticateViewModel) {
        subscribers.removeAll()
        viewModel.isLoading
            .receive(on: DispatchQueue.main)
            .sink { isLoading in
                self.activityIndicator.isHidden = !isLoading
                if isLoading {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
            .store(in: &subscribers)
        viewModel.authenticationUrl
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    self.dismiss(animated: true)
                }
            } receiveValue: { authenticationURL in
                let request = self.viewModel!.webRequest(for: authenticationURL)
                self.webView.load(request)
            }
            .store(in: &subscribers)
    }
}
