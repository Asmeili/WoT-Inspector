//
//  WICrewKit.swift
//  WICrewKit
//
//  Created by Michael Artes on 08.12.22.
//

import UIKit
import WICoreKit
import WICoreUIKit

public enum WICrewKit {
    
    // MARK: Services
    
    private static var apiService: ApiService!
    private static var crewService: CrewService!
    public static func setApiService(_ apiService: ApiService) {
        self.apiService = apiService
        self.crewService = CrewService(apiService)
    }
}
