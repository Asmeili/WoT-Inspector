//
//  AccountService.swift
//  WIAccountKit
//
//  Created by Michael Artes on 03.12.22.
//

import Combine
import WICoreKit

public enum WIAccountKitNetworkError: Error {
    case noDetailsData(response: ApiResponse<[String: AccountDetails]>)
    case noSearchData(response: ApiResponse<[Account]>)
}

public final class AccountService {
    private let apiService: ApiService
    public init(_ apiService: ApiService) {
        self.apiService = apiService
    }
        
    public func details(for accountId: Int) -> AnyPublisher<AccountDetails, Error> {
        let requestBuilder = RequestBuilder(string: "https://api.worldoftanks.eu/wot/account/info/")
            .addQueryItem(name: "account_id", value: String(accountId))
        return apiService.request(from: requestBuilder, into: [String: AccountDetails].self)
            .tryMap { response in
                guard let data = response.data else {
                    throw WIAccountKitNetworkError.noDetailsData(response: response)
                }
                return data[String(accountId)]!
            }
            .eraseToAnyPublisher()
    }
    
    public func search(for searchText: String) -> AnyPublisher<[Account], Error> {
        let requestBuilder = RequestBuilder(string: "https://api.worldoftanks.eu/wot/account/list/")
            .addQueryItem(name: "search", value: searchText)
        return apiService.request(from: requestBuilder, into: [Account].self)
            .tryMap { response in
                guard let data = response.data else {
                    throw WIAccountKitNetworkError.noSearchData(response: response)
                }
                return data
            }
            .eraseToAnyPublisher()
    }
}
