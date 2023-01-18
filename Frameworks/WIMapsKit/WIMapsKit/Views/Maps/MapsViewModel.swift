//
//  MapsViewModel.swift
//  WIMapsKit
//
//  Created by Michael Artes on 07.12.22.
//

import Combine
import WICoreUIKit

public final class MapsViewModel: WITableViewModel {
    public let updateUI = PassthroughSubject<Bool, Never>()
    public var sections = [Section]()
    
    let maps = CurrentValueSubject<[Map], Error>([])
    
    private let mapService: MapService
    init(_ mapService: MapService) {
        self.mapService = mapService
    }
    
    private var subscribers = Set<AnyCancellable>()
    public func setup() {
        subscribers.removeAll()
        mapService.maps()
            .sink { completion in
                print(completion)
                self.maps.send(completion: completion)
            } receiveValue: { maps in
                self.maps.send(maps)
                self.updateUI.send(true)
            }
            .store(in: &subscribers)
    }
    
    public func generateSections() {
        sections = maps.value.map { map in
            Section(title: map.nameI18n, footer: nil, cells: [
                Cell(name: "Name", value: map.nameI18n, accessoryType: .none, action: nil),
                Cell(name: "Arena ID", value: map.arenaId, accessoryType: .none, action: nil),
                Cell(name: "Camouflage Type", value: map.camouflageType.rawValue, accessoryType: .none, action: nil),
                Cell(name: "Description", value: map.description, accessoryType: .none, action: nil),
            ])
        }
    }
}
