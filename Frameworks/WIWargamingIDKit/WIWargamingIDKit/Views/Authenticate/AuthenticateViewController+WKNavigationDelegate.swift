//
//  AuthenticateViewController+WKNavigationDelegate.swift
//  WIWargamingIDKit
//
//  Created by Michael Artes on 03.12.22.
//

import UIKit
import WebKit

extension AuthenticateViewController: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let absoluteString = navigationAction.request.url?.absoluteString,
              let urlComponents = URLComponents(string: absoluteString),
              urlComponents.host == "localhost",
              let viewModel = self.viewModel
        else {
            return decisionHandler(.allow)
        }
        
        guard let accessToken = urlComponents.queryItems?.first(where: { $0.name == "access_token" })?.value,
              let accountIdStr = urlComponents.queryItems?.first(where: { $0.name == "account_id" })?.value,
              let accountId = Int(accountIdStr)
        else {
            dismiss(animated: true)
            return decisionHandler(.cancel)
        }
        
        viewModel.receivedAccessToken(accessToken, for: accountId)
        dismiss(animated: true)
        decisionHandler(.cancel)
    }
}
