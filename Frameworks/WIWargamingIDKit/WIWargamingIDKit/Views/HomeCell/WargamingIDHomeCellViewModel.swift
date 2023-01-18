//
//  WargamingIDHomeCellViewModel.swift
//  WIWargamingIDKit
//
//  Created by Michael Artes on 03.12.22.
//

import Combine

public final class WargamingIDHomeCellViewModel {
    private let authenticateService: AuthenticateService
    init(_ authenticateService: AuthenticateService) {
        self.authenticateService = authenticateService
    }
    
    public lazy var wargamingID = authenticateService.wargamingID
    public lazy var isLoadingWargamingID = authenticateService.isLoadingWargamingID
    
    public var shouldAuthenticate: Bool {
        !authenticateService.isAuthenticated && !authenticateService.isLoadingWargamingID.value
    }
}
