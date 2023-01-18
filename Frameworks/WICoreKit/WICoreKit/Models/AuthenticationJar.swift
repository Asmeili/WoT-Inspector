//
//  AuthenticationJar.swift
//  WICoreKit
//
//  Created by Michael Artes on 03.12.22.
//

import Foundation

public struct AuthenticationJar {
    public let accessToken: String
    public let accountId: Int
    
    // Bruhh fr swift??
    public init(accessToken: String, accountId: Int) {
        self.accessToken = accessToken
        self.accountId = accountId
    }
}
