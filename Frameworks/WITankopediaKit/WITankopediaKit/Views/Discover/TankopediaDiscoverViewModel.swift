//
//  DiscoverViewModel.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 05.12.22.
//

import Combine

public final class TankopediaDiscoverViewModel {
    private let tankopediaService: TankopediaService
    init(_ tankopediaService: TankopediaService) {
        self.tankopediaService = tankopediaService
    }
    
    private var subscribers = Set<AnyCancellable>()
    let information = CurrentValueSubject<TankopediaInformation?, Error>(nil)
    let vehicles = CurrentValueSubject<[Vehicle], Error>([])
    
    let nation = CurrentValueSubject<VehicleNationInternal?, Never>(nil)
    let tier = CurrentValueSubject<Int?, Never>(nil)
    let type = CurrentValueSubject<VehicleTypeInternal?, Never>(nil)
    
    func setup() {
        tankopediaService.information()
            .sink { completion in
                self.information.send(completion: completion)
            } receiveValue: { information in
                self.information.send(information)
            }
            .store(in: &subscribers)
        nation.sink { _ in self.getVehicles() }.store(in: &subscribers)
        tier.sink { _ in self.getVehicles() }.store(in: &subscribers)
        type.sink { _ in self.getVehicles() }.store(in: &subscribers)
        getVehicles()
    }
    
    private var isInitialFetch = true
    private var last: (VehicleNationInternal?, Int?, VehicleTypeInternal?) = (nil, nil, nil)
    private var lastNation: VehicleNationInternal?
    private var lastTier: Int?
    private var lastType: VehicleTypeInternal?
    private func getVehicles() {
        let nation = nation.value
        let tier = tier.value
        let type = type.value
        if nation == last.0, tier == last.1, type == last.2, isInitialFetch == false {
            return
        }
        isInitialFetch = false
        last = (nation, tier, type)
        
        tankopediaService.vehicles(for: nation, in: tier, type: type)
            .sink { completion in
                print(completion)
                // @TODO: DEBUG THIS NONESENSICAL LOC
                // self.vehicles.send(completion: completion)
            } receiveValue: { vehicles in
                // Check for outdated
                guard self.nation.value == nation,
                      self.tier.value == tier,
                      self.type.value == type
                else {
                    return
                }
                
                var vehiclesArray = [Vehicle]()
                for (_, vehicle) in vehicles {
                    vehiclesArray.append(vehicle)
                }
                vehiclesArray.sort { $0.tankId < $1.tankId }
                self.vehicles.send(vehiclesArray)
            }
            .store(in: &subscribers)
    }
    
    var sections = [DiscoverSection]()
    func generateSections() {
        guard let information = information.value else {
            sections = []
            return
        }
        
        var tierCells: [DiscoverItem] = [
            DiscoverItem(name: "All", value: "All1", vehicle: nil)
        ]
        for tier in 1...10 {
            tierCells.append(DiscoverItem(name: "Tier \(tier)", value: String(tier), vehicle: nil))
        }
        
        var nationCells = information.vehicleNations.map {
            DiscoverItem(name: $0.value.rawValue, value: $0.key, vehicle: nil)
        }
        nationCells.append(DiscoverItem(name: "All", value: "All2", vehicle: nil))
        nationCells.sort { $0.name < $1.name }
        
        var typeCells = information.vehicleTypes.map {
            DiscoverItem(name: $0.value.rawValue, value: $0.key, vehicle: nil)
        }
        typeCells.append(DiscoverItem(name: "All", value: "All3", vehicle: nil))
        typeCells.sort { $0.name < $1.name }
        sections = [
            DiscoverSection(type: .chips, items: tierCells),
            DiscoverSection(type: .chips, items: nationCells),
            DiscoverSection(type: .chips, items: typeCells)
        ]
        
        let vehicles = vehicles.value
        if vehicles.count > 0 {
            var vehiclesCells = vehicles.map { vehicle in
                DiscoverItem(name: vehicle.name, value: String(vehicle.tankId), vehicle: vehicle)
            }
            vehiclesCells.sort { lhs, rhs in
                if lhs.vehicle!.tier == rhs.vehicle!.tier {
                    return lhs.vehicle!.name < rhs.vehicle!.name
                }
                return lhs.vehicle!.tier < rhs.vehicle!.tier
            }
            sections.append(DiscoverSection(type: .results, items: vehiclesCells))
        }
    }
}
