//
//  AccountSearchViewModel.swift
//  WIAccountKit
//
//  Created by Michael Artes on 04.12.22.
//

import Combine

public final class AccountSearchViewModel {
    private let accountService: AccountService
    init(_ accountService: AccountService) {
        self.accountService = accountService
    }
    
    let searchText = PassthroughSubject<String, Error>()
    let accounts = CurrentValueSubject<[Account], Error>([])
    
    private var subscribers = Set<AnyCancellable>()
    func setup() {
        searchText
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .removeDuplicates()
            .filter { searchText in
                if searchText.count > 3 {
                    return true
                }
                self.accounts.send([])
                return false
            }
            .map { searchText -> AnyPublisher<[Account], Error> in
                return self.accountService.search(for: searchText)
                    .eraseToAnyPublisher()
            }
            .switchToLatest()
            .sink { completion in
                self.accounts.send(completion: completion)
            } receiveValue: { accounts in
                self.accounts.send(accounts)
            }
            .store(in: &subscribers)
    }
}
