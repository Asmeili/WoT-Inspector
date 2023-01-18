//
//  GunDetailsViewModel.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 07.12.22.
//

import Combine
import WICoreUIKit

final class GunDetailsViewModel: WITableViewModel {
    let updateUI = PassthroughSubject<Bool, Never>()
    var sections = [Section]()
    
    let gun: VehicleGun
    init(for gun: VehicleGun) {
        self.gun = gun
    }
    
    func setup() {
        
    }
    
    func generateSections() {
        sections = [
            Section(title: "Profile", footer: nil, cells: [
                Cell(name: "Name", value: gun.name, accessoryType: .none, action: nil),
                Cell(name: "Tag", value: gun.tag, accessoryType: .none, action: nil),
                Cell(name: "Tier", value: String(gun.tier), accessoryType: .none, action: nil),
                Cell(name: "Weight", value: "\(String(gun.weight))KG", accessoryType: .none, action: nil)
            ]),
            Section(title: "Gun", footer: nil, cells: [
                Cell(name: "Aim Time", value: String(gun.aimTime), accessoryType: .none, action: nil),
                Cell(name: "Caliber", value: "\(String(gun.caliber))mm", accessoryType: .none, action: nil),
                Cell(name: "Dispersion", value: String(gun.dispersion), accessoryType: .none, action: nil),
                Cell(name: "Fire Rate", value: String(gun.fireRate), accessoryType: .none, action: nil),
                Cell(name: "Move Up Arc", value: String(gun.moveUpArc), accessoryType: .none, action: nil),
                Cell(name: "Move Down Arc", value: String(gun.moveDownArc), accessoryType: .none, action: nil),
                Cell(name: "Reload Time", value: String(gun.reloadTime), accessoryType: .none, action: nil),
                Cell(name: "Traverse Speed", value: String(gun.traverseSpeed), accessoryType: .none, action: nil)
            ])
        ]
    }
}
