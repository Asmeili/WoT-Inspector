//
//  MapService.swift
//  WIMapsKit
//
//  Created by Michael Artes on 07.12.22.
//

import Combine
import WICoreKit

enum WIMapKitNetworkError: Error {
    case noMaps(response: ApiResponse<[String: Map]>)
}

final class MapService {
    private let apiService: ApiService
    public init(_ apiService: ApiService) {
        self.apiService = apiService
    }
    
    func maps() -> AnyPublisher<[Map], Error> {
        let requestBuilder = RequestBuilder(string: "https://api.worldoftanks.eu/wot/encyclopedia/arenas/")
            .addQueryItem(name: "language", value: "en")
        return apiService.request(from: requestBuilder, into: [String: Map].self)
            .tryMap { response in
                guard let data = response.data else {
                    throw WIMapKitNetworkError.noMaps(response: response)
                }
                
                var maps = [Map]()
                for (_, map) in data {
                    maps.append(map)
                }
                maps.sort { $0.nameI18n ?? $0.description < $1.nameI18n ?? $1.description }
                return maps
            }
            .eraseToAnyPublisher()
    }
}
