//
//  WIMapsKit.swift
//  WIMapsKit
//
//  Created by Michael Artes on 07.12.22.
//

import UIKit
import WICoreKit
import WICoreUIKit

public enum WIMapsKit {
    
    // MARK: Services
    
    private static var apiService: ApiService!
    private static var mapService: MapService!
    public static func setApiService(_ apiService: ApiService) {
        self.apiService = apiService
        self.mapService = MapService(apiService)
    }
    
    // MARK: Maps
    
    public static func instantiateMapsViewModel() -> MapsViewModel {
        MapsViewModel(mapService)
    }
    
    public static func instantiateMapsViewController(with viewModel: MapsViewModel) -> MapsViewController {
        let storyboard = UIStoryboard(name: "MapsView", bundle: Bundle(for: MapsViewController.self))
        let mapsViewController = storyboard.instantiateViewController(withIdentifier: "MapsViewController") as! MapsViewController
        mapsViewController.viewModel_ = viewModel
        return TabBarFactory.viewController(from: mapsViewController)
    }
}
