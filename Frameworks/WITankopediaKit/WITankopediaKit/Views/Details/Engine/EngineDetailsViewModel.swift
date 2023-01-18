//
//  EngineDetailsViewModel.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 07.12.22.
//

import Combine
import WICoreUIKit

final class EngineDetailsViewModel: WITableViewModel {
    let updateUI = PassthroughSubject<Bool, Never>()
    var sections = [Section]()
    
    let engine: VehicleEngine
    init(for engine: VehicleEngine) {
        self.engine = engine
    }
    
    func setup() {
        
    }
    
    func generateSections() {
        sections = [
            Section(title: "Profile", footer: nil, cells: [
                Cell(name: "Name", value: engine.name ?? "N/A", accessoryType: .none, action: nil),
                Cell(name: "Tag", value: engine.tag, accessoryType: .none, action: nil),
                Cell(name: "Tier", value: String(engine.tier), accessoryType: .none, action: nil),
                Cell(name: "Weight", value: "\(String(engine.weight))KG", accessoryType: .none, action: nil)
            ]),
            Section(title: "Engine", footer: nil, cells: [
                Cell(name: "Fire Chance", value: "\(String(engine.fireChance))%", accessoryType: .none, action: nil),
                Cell(name: "Power", value: "\(String(engine.power))PS", accessoryType: .none, action: nil),
            ])
        ]
    }
}
