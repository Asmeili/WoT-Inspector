//
//  ProvisionsDetailsViewModel.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 08.12.22.
//

import Combine
import WICoreUIKit

final class ProvisionsDetailsViewModel: WITableViewModel {
    let updateUI = PassthroughSubject<Bool, Never>()
    var sections = [Section]()
    
    let provisions = CurrentValueSubject<[Provision], Error>([])
    
    private let tankopediaService: TankopediaService
    private let provisionIds: [Int]
    init(_ tankopediaService: TankopediaService, for provisionIds: [Int]) {
        self.tankopediaService = tankopediaService
        self.provisionIds = provisionIds
    }
    
    private var subscribers = Set<AnyCancellable>()
    func setup() {
        subscribers.removeAll()
        
        let firstIds = provisionIds[0...99]
        tankopediaService.provisions(for: firstIds)
            .sink { completion in
                self.provisions.send(completion: completion)
            } receiveValue: { provisions in
                self.provisions.send(provisions)
                self.updateUI.send(true)
            }
            .store(in: &subscribers)
    }
    
    func generateSections() {
        sections = [
            Section(title: "Provisions", footer: nil, cells: provisions.value.map { provision in
                Cell(name: provision.name, value: provision.type.readable(), accessoryType: .disclosureIndicator) { viewController in
                    let provisionDetailsViewModel = WITankopediaKit.instantiateProvisionDetailsViewModel(for: provision)
                    let provisionDetailsViewController = WITankopediaKit.instantiateProvisionDetailsViewController(with: provisionDetailsViewModel)
                    viewController.navigationController?.pushViewController(provisionDetailsViewController, animated: true)
                }
            })
        ]
    }
}
