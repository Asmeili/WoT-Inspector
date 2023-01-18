//
//  AuthenticateViewModel.swift
//  WIWargamingIDKit
//
//  Created by Michael Artes on 03.12.22.
//

import Combine

public final class AuthenticateViewModel {
    private let authenticateService: AuthenticateService
    public init(_ authenticateService: AuthenticateService) {
        self.authenticateService = authenticateService
    }
    
    private var subscribers = Set<AnyCancellable>()
    func setup() {
        authenticateService.authenticationURL()
            .sink { completion in
                self.authenticationUrl.send(completion: completion)
            } receiveValue: { authenticationString in
                guard let authenticationURL = URL(string: authenticationString) else { return }
                self.authenticationUrl.send(authenticationURL)
                self.isLoading.send(false)
            }
            .store(in: &subscribers)
    }
    
    var isLoading = CurrentValueSubject<Bool, Never>(true)
    var authenticationUrl = PassthroughSubject<URL, Error>()
    
    func webRequest(for url: URL) -> URLRequest {
        return URLRequest(url: url)
    }
    
    func receivedAccessToken(_ accessToken: String, for accountId: Int) {
        authenticateService.setAuthenticationJar(to: accessToken, for: accountId)
    }
}
