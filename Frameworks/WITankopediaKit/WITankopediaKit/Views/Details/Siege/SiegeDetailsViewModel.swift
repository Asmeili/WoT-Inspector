//
//  SiegeDetailsViewModel.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 07.12.22.
//

import Combine
import WICoreUIKit

final class SiegeDetailsViewModel: WITableViewModel {
    let updateUI = PassthroughSubject<Bool, Never>()
    var sections = [Section]()
    
    private let siege: VehicleSiege
    init(for siege: VehicleSiege) {
        self.siege = siege
    }
    
    func setup() {
        
    }
    
    func generateSections() {
        sections = [
            Section(title: "Siege", footer: nil, cells: [
                Cell(name: "Aim Time", value: String(siege.aimTime), accessoryType: .none, action: nil),
                Cell(name: "Dispersion", value: String(siege.dispersion), accessoryType: .none, action: nil),
                Cell(name: "Move Up Arc", value: String(siege.moveUpArc), accessoryType: .none, action: nil),
                Cell(name: "Move Down Arc", value: String(siege.moveDownArc), accessoryType: .none, action: nil),
                Cell(name: "Reload Time", value: String(siege.reloadTime), accessoryType: .none, action: nil),
                Cell(name: "Speed Backward", value: String(siege.speedBackward), accessoryType: .none, action: nil),
                Cell(name: "Suspension Traverse Speed", value: String(siege.suspensionTraverseSpeed), accessoryType: .none, action: nil),
                Cell(name: "Switch On Time", value: String(siege.switchOnTime), accessoryType: .none, action: nil),
                Cell(name: "Switch Off Time", value: String(siege.switchOffTime), accessoryType: .none, action: nil),
                
            ])
        ]
    }
}
