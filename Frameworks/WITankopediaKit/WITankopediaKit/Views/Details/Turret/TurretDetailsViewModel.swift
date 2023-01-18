//
//  TurretDetailsViewModel.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 07.12.22.
//

import Combine
import WICoreUIKit

final class TurretDetailsViewModel: WITableViewModel {
    let updateUI = PassthroughSubject<Bool, Never>()
    var sections = [Section]()
    
    let turret: VehicleTurret
    init(for turret: VehicleTurret) {
        self.turret = turret
    }
    
    func setup() {
        
    }
    
    func generateSections() {
        var turretCells: [Cell] = [
            Cell(name: "HP", value: String(turret.hp), accessoryType: .none, action: nil),
            Cell(name: "View Range", value: String(turret.viewRange), accessoryType: .none, action: nil),
        ]
        
        if let traverseSpeed = turret.traverseSpeed {
            turretCells.append(Cell(name: "Traverse Speed", value: String(traverseSpeed), accessoryType: .none, action: nil))
        }
        
        if let traverseArcRight = turret.traverseRightArc {
            turretCells.append(Cell(name: "Traverse Arc Right", value: String(traverseArcRight), accessoryType: .none, action: nil))
        }
        
        if let traverseArcLeft = turret.traverseLeftArc {
            turretCells.append(Cell(name: "Traverse Arc Left", value: String(traverseArcLeft), accessoryType: .none, action: nil))
        }
        
        sections = [
            Section(title: "Profile", footer: nil, cells: [
                Cell(name: "Name", value: turret.name, accessoryType: .none, action: nil),
                Cell(name: "Tag", value: turret.tag, accessoryType: .none, action: nil),
                Cell(name: "Tier", value: String(turret.tier), accessoryType: .none, action: nil),
                Cell(name: "Weight", value: "\(String(turret.weight))KG", accessoryType: .none, action: nil)
            ]),
            Section(title: "Turret", footer: nil, cells: turretCells)
        ]
    }
}
