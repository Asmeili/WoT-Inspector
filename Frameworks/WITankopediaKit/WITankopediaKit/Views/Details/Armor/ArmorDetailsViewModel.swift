//
//  ArmorDetailsViewModel.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 07.12.22.
//

import Combine
import WICoreUIKit

final class ArmorDetailsViewModel: WITableViewModel {
    let updateUI = PassthroughSubject<Bool, Never>()
    var sections = [Section]()
    
    private let armor: VehicleArmor
    init(for armor: VehicleArmor) {
        self.armor = armor
    }
    
    func setup() {
        
    }
    
    func generateSections() {
        sections = []
        
        if let turret = armor.turret {
            sections.append(section(for: turret, as: "Turret"))
        }
        sections.append(section(for: armor.hull, as: "Hull"))
    }
    
    private func section(for armor: VehicleModuleArmor, as title: String) -> Section {
        Section(title: title, footer: nil, cells: [
            Cell(name: "Front", value: String(armor.front), accessoryType: .none, action: nil),
            Cell(name: "Rear", value: String(armor.rear), accessoryType: .none, action: nil),
            Cell(name: "Sides", value: String(armor.sides), accessoryType: .none, action: nil),
        ])
    }
}
