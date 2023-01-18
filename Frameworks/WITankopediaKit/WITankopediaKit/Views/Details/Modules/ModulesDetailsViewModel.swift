//
//  ModulesDetailsViewModel.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 07.12.22.
//

import Combine
import WICoreUIKit

final class ModulesDetailsViewModel: WITableViewModel {
    let updateUI = PassthroughSubject<Bool, Never>()
    var sections = [Section]()
    
    let modules = CurrentValueSubject<[Module], Error>([])
    
    private let tankopediaService: TankopediaService
    private let moduleIds: [Int]
    init(_ tankopediaService: TankopediaService, for moduleIds: [Int]) {
        self.tankopediaService = tankopediaService
        self.moduleIds = moduleIds
    }
    
    private var subscribers = Set<AnyCancellable>()
    func setup() {
        tankopediaService.modules(for: moduleIds)
            .sink { completion in
                self.modules.send(completion: completion)
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    self.updateUI.send(true)
                }
            } receiveValue: { modules in
                self.updateUI.send(true)
                self.modules.send(modules)
            }
            .store(in: &subscribers)
    }
    
    func generateSections() {
        let modules = modules.value
        let modulesCells = modules.map { module in
            Cell(name: module.name, value: module.type.readable(), accessoryType: .detailButton) { viewController in
                let moduleDetailsViewModel = WITankopediaKit.instantiateModuleDetailsViewModel(for: module)
                let moduleDetailsViewController = WITankopediaKit.instantiateModuleDetailsViewController(with: moduleDetailsViewModel)
                viewController.navigationController?.pushViewController(moduleDetailsViewController, animated: true)
            }
        }
        sections = [
            Section(title: "Modules", footer: nil, cells: modulesCells)
        ]
    }
}
