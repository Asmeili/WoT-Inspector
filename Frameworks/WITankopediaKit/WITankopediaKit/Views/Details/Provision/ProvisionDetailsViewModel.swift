//
//  ProvisionDetailsViewModel.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 08.12.22.
//

import Combine
import WICoreUIKit

final class ProvisionDetailsViewModel: WITableViewModel {
    let updateUI = PassthroughSubject<Bool, Never>()
    var sections = [Section]()
    
    let provision: Provision
    init(for provision: Provision) {
        self.provision = provision
    }
    
    func setup() {
        
    }
    
    func generateSections() {
        var profileCells: [Cell] = [
            Cell(name: "Name", value: provision.name),
            Cell(name: "Tag", value: provision.tag)
        ]
        
        if let weight = provision.weight {
            profileCells.append(Cell(name: "Weight", value: "\(weight)KG"))
        }
        
        var provisionCells: [Cell] = [
            Cell(name: "Provision ID", value: String(provision.provisionId)),
            Cell(name: "Type", value: String(provision.type.readable())),
            Cell(name: "Price Gold", value: String(provision.priceGold)),
            Cell(name: "Price Credit", value: String(provision.priceCredit))
        ]
        
        if let description = provision.description {
            provisionCells.append(Cell(name: "Description", value: description))
        }
        
        sections = [
            Section(title: nil, footer: nil, cells: [
                Cell(name: "BigIcon")
            ]),
            Section(title: "Profile", footer: nil, cells: profileCells),
            Section(title: "Provision", footer: nil, cells: provisionCells)
        ]
    }
}
