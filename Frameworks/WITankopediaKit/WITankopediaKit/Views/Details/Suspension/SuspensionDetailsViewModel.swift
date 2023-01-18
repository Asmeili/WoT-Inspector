//
//  SuspensionDetailsViewModel.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 07.12.22.
//

import Combine
import WICoreUIKit

final class SuspensionDetailsViewModel: WITableViewModel {
    let updateUI = PassthroughSubject<Bool, Never>()
    var sections = [Section]()
    
    let suspension: VehicleSuspension
    init(for suspension: VehicleSuspension) {
        self.suspension = suspension
    }
    
    func setup() {
        
    }
    
    func generateSections() {
        sections = [
            Section(title: "Profile", footer: nil, cells: [
                Cell(name: "Name", value: suspension.name, accessoryType: .none, action: nil),
                Cell(name: "Tag", value: suspension.tag, accessoryType: .none, action: nil),
                Cell(name: "Tier", value: String(suspension.tier), accessoryType: .none, action: nil),
                Cell(name: "Weight", value: "\(String(suspension.weight))KG", accessoryType: .none, action: nil)
            ]),
            Section(title: "Suspension", footer: nil, cells: [
                Cell(name: "Load Limit", value: "\(String(suspension.loadLimit))KG", accessoryType: .none, action: nil),
                Cell(name: "Steering Lock Angle", value: String(suspension.steeringLockAngle), accessoryType: .none, action: nil),
                Cell(name: "Traverse Speed", value: String(suspension.traverseSpeed), accessoryType: .none, action: nil),
            ])
        ]
    }
}
