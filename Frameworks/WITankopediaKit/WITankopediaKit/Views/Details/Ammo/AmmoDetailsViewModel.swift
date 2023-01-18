//
//  AmmoDetailsViewModel.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 07.12.22.
//

import Combine
import WICoreUIKit

final class AmmoDetailsViewModel: WITableViewModel {
    let updateUI = PassthroughSubject<Bool, Never>()
    var sections = [Section]()
    
    let ammo: [VehicleAmmo]
    init(for ammo: [VehicleAmmo]) {
        self.ammo = ammo.sorted { $0.type < $1.type }
    }
    
    func setup() {
        
    }
    
    func generateSections() {
        sections = []
        for ammo in self.ammo {
            var ammoCells: [Cell] = [
                Cell(name: "Type", value: ammo.type, accessoryType: .none, action: nil),
                Cell(name: "Damage", value: ammo.damage.concat(with: ", "), accessoryType: .none, action: nil),
                Cell(name: "Penetration", value: ammo.penetration.concat(with: ", "), accessoryType: .none, action: nil),
            ]
            
            if let stun = ammo.stun {
                if stun.duration.allSatisfy({ $0 == 0 }) {
                    ammoCells.append(Cell(name: "Stun Duration", value: "None 😄", accessoryType: .none, action: nil))
                } else {
                    ammoCells.append(Cell(name: "Stun Duration", value: stun.duration.concat(with: ", "), accessoryType: .none, action: nil))
                }
            }
            
            sections.append(Section(title: nil, footer: nil, cells: ammoCells))
        }
    }
}
