//
//  CrewDetailsViewModel.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 07.12.22.
//

import Combine
import WICoreUIKit

final class CrewDetailsViewModel: WITableViewModel {
    let updateUI = PassthroughSubject<Bool, Never>()
    var sections = [Section]()
    
    private let crew: [VehicleCrew]
    init(for crew: [VehicleCrew]) {
        self.crew = crew
    }
    
    func setup() {
        
    }
    
    func generateSections() {
        let crew = crew.sorted { $0.memberId < $1.memberId }
        sections = crew.map { crewMember in
            var roles = [String]()
            for (_, role) in crewMember.roles {
                roles.append(role.rawValue)
            }
            roles.sort { $0 < $1 }
            
            var name = "Role"
            if roles.count > 1 {
                name = "Roles"
            }
            
            return Section(title: crewMember.memberId, footer: nil, cells: [
                Cell(name: "Name", value: crewMember.memberId),
                Cell(name: name, value: roles.concat(with: ", "))
            ])
        }
    }
}
