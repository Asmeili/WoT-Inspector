//
//  Account.swift
//  WIAccountKit
//
//  Created by Michael Artes on 04.12.22.
//

import Foundation

public struct Account: Codable {
    public let accountId: Int
    public let nickname: String
    public init(accountId: Int, nickname: String) {
        self.accountId = accountId
        self.nickname = nickname
    }
}
