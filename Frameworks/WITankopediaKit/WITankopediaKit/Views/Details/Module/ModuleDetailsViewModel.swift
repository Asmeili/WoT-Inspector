//
//  ModuleDetailsViewModel.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 07.12.22.
//

import Combine
import WICoreUIKit

final class ModuleDetailsViewModel: WITableViewModel {
    let updateUI = PassthroughSubject<Bool, Never>()
    var sections = [Section]()
    
    let module: Module
    init(for module: Module) {
        self.module = module
    }
    
    func setup() {
        
    }
    
    func generateSections() {
        sections = [
            Section(title: nil, footer: nil, cells: [
                Cell(name: "BigIcon", value: nil, accessoryType: .none, action: nil)
            ]),
            Section(title: "Profile", footer: nil, cells: [
                Cell(name: "Name", value: module.name, accessoryType: .none, action: nil),
                Cell(name: "Nation", value: module.nation.readable().rawValue, accessoryType: .none, action: nil),
                Cell(name: "Tanks", value: String(module.tanks.count), accessoryType: .none, action: nil),
                Cell(name: "Tier", value: String(module.tier), accessoryType: .none, action: nil),
                Cell(name: "Weight", value: "\(String(module.weight))KG", accessoryType: .none, action: nil),
                Cell(name: "Price Credits", value: String(module.priceCredit), accessoryType: .none, action: nil)
            ])
        ]
        
        if let engine = module.defaultProfile?.engine {
            sections.append(Section(title: "Engine", footer: nil, cells: [
                Cell(name: "Fire Chance", value: "\(String(engine.fireChance))%", accessoryType: .none, action: nil),
                Cell(name: "Power", value: "\(String(engine.power))PS", accessoryType: .none, action: nil),
            ]))
        }
        
        if let gun = module.defaultProfile?.gun {
            sections.append(Section(title: "Gun", footer: nil, cells: [
                Cell(name: "Ammo", value: String(gun.ammo.count), accessoryType: .detailButton) { viewController in
                    let ammoDetailsViewModel = WITankopediaKit.instantiateAmmoDetailsViewModel(for: gun.ammo)
                    let ammoDetailsViewController = WITankopediaKit.instantiateAmmoDetailsViewController(with: ammoDetailsViewModel)
                    viewController.navigationController?.pushViewController(ammoDetailsViewController, animated: true)
                },
                Cell(name: "Aim Time", value: String(gun.aimTime), accessoryType: .none, action: nil),
                Cell(name: "Dispersion", value: String(gun.dispersion), accessoryType: .none, action: nil),
                Cell(name: "Fire Rate", value: String(gun.fireRate), accessoryType: .none, action: nil),
                Cell(name: "Max Ammo", value: String(gun.maxAmmo), accessoryType: .none, action: nil),
                Cell(name: "Move Up Arc", value: String(gun.moveUpArc), accessoryType: .none, action: nil),
                Cell(name: "Move Down Arc", value: String(gun.moveDownArc), accessoryType: .none, action: nil),
                Cell(name: "Reload Time", value: String(gun.reloadTime), accessoryType: .none, action: nil),
                Cell(name: "Traverse Speed", value: String(gun.traverseSpeed), accessoryType: .none, action: nil)
            ]))
        }
        
        if let radio = module.defaultProfile?.radio {
            sections.append(Section(title: "Radio", footer: nil, cells: [
                Cell(name: "Signal Range", value: "\(String(radio.signalRange))m", accessoryType: .none, action: nil)
            ]))
        }
        
        if let suspension = module.defaultProfile?.suspension {
            sections.append(Section(title: "Suspension", footer: nil, cells: [
                Cell(name: "Load Limit", value: "\(String(suspension.loadLimit))KG", accessoryType: .none, action: nil),
                Cell(name: "Traverse Speed", value: String(suspension.traverseSpeed), accessoryType: .none, action: nil)
            ]))
        }
        
        if let turret = module.defaultProfile?.turret {
            sections.append(Section(title: "Turret", footer: nil, cells: [
                Cell(name: "Armor Front", value: String(turret.armorFront), accessoryType: .none, action: nil),
                Cell(name: "Armor Rear", value: String(turret.armorRear), accessoryType: .none, action: nil),
                Cell(name: "Armor Sides", value: String(turret.armorSides), accessoryType: .none, action: nil),
                Cell(name: "HP", value: String(turret.hp), accessoryType: .none, action: nil),
                Cell(name: "Traverse Speed", value: String(turret.traverseSpeed), accessoryType: .none, action: nil),
                Cell(name: "View Range", value: String(turret.viewRange), accessoryType: .none, action: nil),
            ]))
        }
    }
}
