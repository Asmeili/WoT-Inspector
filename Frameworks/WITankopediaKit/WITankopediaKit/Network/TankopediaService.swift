//
//  TankopediaService.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 04.12.22.
//

import Combine
import WICoreKit

public enum WITankopediaNetworkError: Error {
    case noInformationData(response: ApiResponse<TankopediaInformation>)
    case noVehicleData(response: ApiResponse<[String: Vehicle]>)
    case noModuleData(response: ApiResponse<[String: Module]>)
    case noProvisionData(response: ApiResponse<[String: Provision]>)
}

public final class TankopediaService {
    private let apiService: ApiService
    public init(_ apiService: ApiService) {
        self.apiService = apiService
    }
    
    // MARK: Information
    
    public func information() -> AnyPublisher<TankopediaInformation, Error> {
        let requestBuilder = RequestBuilder(string: "https://api.worldoftanks.eu/wot/encyclopedia/info/")
        return apiService.request(from: requestBuilder, into: TankopediaInformation.self)
            .tryMap { response in
                guard let data = response.data else {
                    throw WITankopediaNetworkError.noInformationData(response: response)
                }
                return data
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: Vehicles
    
    public func vehicles(for nation: VehicleNationInternal?, in tier: Int?, type: VehicleTypeInternal?) -> AnyPublisher<[String: Vehicle], Error> {
        let requestBuilder = RequestBuilder(string: "https://api.worldoftanks.eu/wot/encyclopedia/vehicles/")
            .addQueryItem(name: "limit", value: String(100))
            .addQueryItem(name: "page_no", value: String(1))

        if let nation {
            _ = requestBuilder.addQueryItem(name: "nation", value: nation.rawValue)
        }
        if let tier {
            _ = requestBuilder.addQueryItem(name: "tier", value: String(tier))
        }
        if let type {
            _ = requestBuilder.addQueryItem(name: "type", value: type.rawValue)
        }
        
        return apiService.request(from: requestBuilder, into: [String: Vehicle].self)
            .tryMap { response in
                guard let data = response.data else {
                    throw WITankopediaNetworkError.noVehicleData(response: response)
                }
                return data
            }
            .eraseToAnyPublisher()
    }
    
    public func vehicles(for tankId: Int) -> AnyPublisher<Vehicle, Error> {
        let requestBuilder = RequestBuilder(string: "https://api.worldoftanks.eu/wot/encyclopedia/vehicles/")
            .addQueryItem(name: "limit", value: String(1))
            .addQueryItem(name: "page_no", value: String(1))
            .addQueryItem(name: "tank_id", value: String(tankId))
        return apiService.request(from: requestBuilder, into: [String: Vehicle].self)
            .tryMap { response in
                guard let data = response.data,
                      let vehicle = data[String(tankId)]
                else {
                    throw WITankopediaNetworkError.noVehicleData(response: response)
                }
                return vehicle
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: Modules
    
    public func modules(for moduleIds: [Int]) -> AnyPublisher<[Module], Error> {
        let requestBuilder = RequestBuilder(string: "https://api.worldoftanks.eu/wot/encyclopedia/modules/")
            .addQueryItem(name: "limit", value: String(moduleIds.count))
            .addQueryItem(name: "page_no", value: String(1))
            .addQueryItem(name: "module_id", value: moduleIds.concat(with: ","))
            .addQueryItem(name: "extra", value: "default_profile")
        return apiService.request(from: requestBuilder, into: [String: Module].self)
            .tryMap { response in
                guard let data = response.data
                else {
                    throw WITankopediaNetworkError.noModuleData(response: response)
                }
                
                var modules = [Module]()
                for (_, module) in data {
                    modules.append(module)
                }
                return modules
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: Provisions
    
    public func provisions(for provisionIds: (any Collection<Int>)) -> AnyPublisher<[Provision], Error> {
        let requestBuilder = RequestBuilder(string: "https://api.worldoftanks.eu/wot/encyclopedia/provisions/")
            .addQueryItem(name: "limit", value: String(100))
            .addQueryItem(name: "page_no", value: String(1))
            .addQueryItem(name: "provision_id", value: provisionIds.concat(with: ","))
        return apiService.request(from: requestBuilder, into: [String: Provision].self)
            .tryMap { response in
                guard let data = response.data else {
                    throw WITankopediaNetworkError.noProvisionData(response: response)
                }
                
                var provisions = [Provision]()
                for (_, provision) in data {
                    provisions.append(provision)
                }
                provisions.sort {
                    if $0.name == $1.name {
                        return $0.provisionId < $1.provisionId
                    }
                    return $0.name < $1.name
                }
                return provisions
            }
            .eraseToAnyPublisher()
    }
}
