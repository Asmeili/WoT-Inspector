//
//  RadioDetailsViewModel.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 07.12.22.
//

import Combine
import WICoreUIKit

final class RadioDetailsViewModel: WITableViewModel {
    let updateUI = PassthroughSubject<Bool, Never>()
    var sections = [Section]()
    
    let radio: VehicleRadio
    init(for radio: VehicleRadio) {
        self.radio = radio
    }
    
    func setup() {
        
    }
    
    func generateSections() {
        sections = [
            Section(title: "Profile", footer: nil, cells: [
                Cell(name: "Name", value: radio.name ?? "N/A", accessoryType: .none, action: nil),
                Cell(name: "Tag", value: radio.tag, accessoryType: .none, action: nil),
                Cell(name: "Tier", value: String(radio.tier), accessoryType: .none, action: nil),
                Cell(name: "Weight", value: "\(radio.weight)KG", accessoryType: .none, action: nil)
            ]),
            Section(title: "Radio", footer: nil, cells: [
                Cell(name: "Signal Range", value: "\(String(radio.signalRange))m", accessoryType: .none, action: nil),
            ])
        ]
    }
}
