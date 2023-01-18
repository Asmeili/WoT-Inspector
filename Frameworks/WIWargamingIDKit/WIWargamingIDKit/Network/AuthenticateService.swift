//
//  AuthenticateService.swift
//  WIWargamingIDKit
//
//  Created by Michael Artes on 03.12.22.
//

import Combine
import WIAccountKit
import WICoreKit

public enum WIWargamingIDKitNetworkError: Error {
    case noData(response: ApiResponse<AuthenticationURLResponse>)
}

public final class AuthenticateService {
    private let apiService: ApiService
    public init(_ apiService: ApiService) {
        self.apiService = apiService
    }
    
    public let wargamingID = CurrentValueSubject<AccountDetails?, Error>(nil)
    public lazy var isLoadingWargamingID = CurrentValueSubject<Bool, Never>(isAuthenticated)
    
    public var isAuthenticated: Bool {
        apiService.authenticationJar.value != nil && wargamingID.value != nil
    }
    
    private var subscribers = Set<AnyCancellable>()
    public func setAuthenticationJar(to accessToken: String, for accountId: Int) {
        let authenticationJar = AuthenticationJar(accessToken: accessToken, accountId: accountId)
        apiService.authenticationJar.send(authenticationJar)
        isLoadingWargamingID.send(true)
        WIAccountKit.accountService.details(for: authenticationJar.accountId)
            .sink { completion in
                self.wargamingID.send(completion: completion)
            } receiveValue: { accountDetails in
                self.wargamingID.send(accountDetails)
                self.isLoadingWargamingID.send(false)
            }
            .store(in: &subscribers)
    }
    
    // https://developers.wargaming.net/reference/all/wot/auth/login/
    public func authenticationURL() -> AnyPublisher<String, Error> {
        let requestBuilder = RequestBuilder(string: "https://api.worldoftanks.eu/wot/auth/login/")
            .addQueryItem(name: "display", value: "popup")
            .addQueryItem(name: "nofollow", value: "1")
            .addQueryItem(name: "redirect_uri", value: "http://localhost")
        return apiService.request(from: requestBuilder, into: AuthenticationURLResponse.self)
            .tryMap { response in
                guard let data = response.data else {
                    throw WIWargamingIDKitNetworkError.noData(response: response)
                }
                return data.location
            }
            .eraseToAnyPublisher()
    }
}
