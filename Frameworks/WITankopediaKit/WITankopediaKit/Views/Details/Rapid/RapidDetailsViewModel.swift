//
//  RapidDetailsViewModel.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 07.12.22.
//

import Combine
import WICoreUIKit

final class RapidDetailsViewModel: WITableViewModel {
    let updateUI = PassthroughSubject<Bool, Never>()
    var sections = [Section]()
    
    private let rapid: VehicleRapid
    init(for rapid: VehicleRapid) {
        self.rapid = rapid
    }
    
    func setup() {
        
    }
    
    func generateSections() {
        sections = [
            Section(title: "Rapid", footer: nil, cells: [
                Cell(name: "Speed Forward", value: String(rapid.speedForward), accessoryType: .none, action: nil),
                Cell(name: "Speed Backward", value: String(rapid.speedBackward), accessoryType: .none, action: nil),
                Cell(name: "Switch On Time", value: String(rapid.switchOnTime), accessoryType: .none, action: nil),
                Cell(name: "Switch Off Time", value: String(rapid.switchOffTime), accessoryType: .none, action: nil),
                Cell(name: "Suspension Steering Lock Angle", value: String(rapid.suspensionSteeringLockAngle), accessoryType: .none, action: nil),
            ])
        ]
    }
}
