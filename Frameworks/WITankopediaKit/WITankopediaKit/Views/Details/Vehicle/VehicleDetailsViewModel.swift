//
//  VehicleDetailsViewModel.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 07.12.22.
//

import Combine
import WICoreUIKit

public final class VehicleDetailsViewModel: WITableViewModel {
    public var updateUI = PassthroughSubject<Bool, Never>()
    public var sections = [Section]()
    
    let vehicle = CurrentValueSubject<Vehicle?, Error>(nil)
    private let tankopediaService: TankopediaService
    private let tankId: Int
    init(_ tankopediaService: TankopediaService, for tankId: Int) {
        self.tankopediaService = tankopediaService
        self.tankId = tankId
    }
    
    init(_ tankopediaService: TankopediaService, for vehicle: Vehicle) {
        self.tankopediaService = tankopediaService
        self.tankId = vehicle.tankId
        self.vehicle.send(vehicle)
    }
    
    private var subscribers = Set<AnyCancellable>()
    public func setup() {
        if vehicle.value == nil {
            tankopediaService.vehicles(for: tankId)
                .sink { completion in
                    self.vehicle.send(completion: completion)
                } receiveValue: { vehicle in
                    self.vehicle.send(vehicle)
                }
                .store(in: &subscribers)
        }
    }
    
    public func generateSections() {
        guard let vehicle = vehicle.value else {
            sections = []
            return
        }
        
        var profileCells: [Cell] = [
            Cell(name: "Tank ID", value: String(vehicle.tankId), accessoryType: .none, action: nil),
            Cell(name: "Name", value: vehicle.name, accessoryType: .none, action: nil),
            Cell(name: "Short Name", value: vehicle.shortName, accessoryType: .none, action: nil),
            Cell(name: "Type", value: vehicle.type.readable().rawValue, accessoryType: .none, action: nil),
            Cell(name: "Nation", value: vehicle.nation.readable().rawValue, accessoryType: .none, action: nil),
            Cell(name: "Tier", value: String(vehicle.tier), accessoryType: .none, action: nil),
            Cell(name: "Description", value: vehicle.description, accessoryType: .none, action: nil),
            Cell(name: "Tag", value: vehicle.tag, accessoryType: .none, action: nil),
            Cell(name: "Is Premium", value: vehicle.isPremium.readable(), accessoryType: .none, action: nil),
            Cell(name: "Is Premium IGR", value: vehicle.isPremiumIgr.readable(), accessoryType: .none, action: nil),
            Cell(name: "Is Gift", value: vehicle.isGift.readable(), accessoryType: .none, action: nil),
            Cell(name: "̄Is Wheeled", value: vehicle.isWheeled.readable(), accessoryType: .none, action: nil),
            Cell(name: "Is Multination", value: vehicle.multination?.readable() ?? "N/A", accessoryType: .none, action: nil)
        ]
        if let priceGold = vehicle.priceGold, priceGold > 0 {
            profileCells.append(Cell(name: "Gold Price", value: String(priceGold), accessoryType: .none, action: nil))
        }
        if let priceCredit = vehicle.priceCredit, (priceCredit > 0 || vehicle.tier == 1) {
            profileCells.append(Cell(name: "Credit Price", value: String(priceCredit), accessoryType: .none, action: nil))
        }
        
        var defaultProfileCells: [Cell] = [
            Cell(name: "Spped Forward", value: String(vehicle.defaultProfile.speedForward), accessoryType: .none, action: nil),
            Cell(name: "Speed Backward", value: String(vehicle.defaultProfile.speedBackward), accessoryType: .none, action: nil),
            Cell(name: "Weight", value: "\(String(vehicle.defaultProfile.weight))KG", accessoryType: .none, action: nil),
            Cell(name: "Hull Weight", value: "\(String(vehicle.defaultProfile.hullWeight))KG", accessoryType: .none, action: nil),
            Cell(name: "HP", value: String(vehicle.defaultProfile.hp), accessoryType: .none, action: nil),
            Cell(name: "Hull HP", value: String(vehicle.defaultProfile.hullHp), accessoryType: .none, action: nil),
            Cell(name: "Ammo", value: String(vehicle.defaultProfile.ammo.count), accessoryType: .detailButton) { viewController in
                let ammoDetailsViewModel = WITankopediaKit.instantiateAmmoDetailsViewModel(for: vehicle.defaultProfile.ammo)
                let ammoDetailsViewController = WITankopediaKit.instantiateAmmoDetailsViewController(with: ammoDetailsViewModel)
                viewController.navigationController?.pushViewController(ammoDetailsViewController, animated: true)
            },
            Cell(name: "Armor", value: String(vehicle.defaultProfile.armor.hull.front), accessoryType: .detailButton) { viewController in
                let armorDetailsViewModel = WITankopediaKit.instantiateArmorDetailsViewModel(for: vehicle.defaultProfile.armor)
                let armorDetailsViewController = WITankopediaKit.instantaiteArmorDetailsViewController(with: armorDetailsViewModel)
                viewController.navigationController?.pushViewController(armorDetailsViewController, animated: true)
            },
            Cell(name: "Engine", value: String(vehicle.defaultProfile.engine.name ?? "N/A"), accessoryType: .detailButton) { viewController in
                let engineDetailsViewModel = WITankopediaKit.instantiateEngineDetailsViewModel(for: vehicle.defaultProfile.engine)
                let engineDetailsViewController = WITankopediaKit.instantiateEngineDetailsViewController(with: engineDetailsViewModel)
                viewController.navigationController?.pushViewController(engineDetailsViewController, animated: true)
            },
            Cell(name: "Gun", value: String(vehicle.defaultProfile.gun.name), accessoryType: .detailButton) { viewController in
                let gunDetailsViewModel = WITankopediaKit.instantiateGunDetailsViewModel(for: vehicle.defaultProfile.gun)
                let gunDetailsViewController = WITankopediaKit.instantiateGunDetailsViewController(with: gunDetailsViewModel)
                viewController.navigationController?.pushViewController(gunDetailsViewController, animated: true)
            },
            Cell(name: "Radio", value: String(vehicle.defaultProfile.radio.name ?? "N/A"), accessoryType: .detailButton) { viewController in
                let radioDetailsViewModel = WITankopediaKit.instantiateRadioDetailsViewModel(for: vehicle.defaultProfile.radio)
                let radioDetailsViewController = WITankopediaKit.instantiateRadioDetailsViewController(with: radioDetailsViewModel)
                viewController.navigationController?.pushViewController(radioDetailsViewController, animated: true)
            },
            Cell(name: "Suspension", value: String(vehicle.defaultProfile.suspension.name), accessoryType: .detailButton) { viewController in
                let suspensionDetailsViewModel = WITankopediaKit.instantiateSuspensionDetailsViewModel(for: vehicle.defaultProfile.suspension)
                let suspensionDetailsViewController = WITankopediaKit.instantiateSuspensionDetailsViewController(with: suspensionDetailsViewModel)
                viewController.navigationController?.pushViewController(suspensionDetailsViewController, animated: true)
            }
        ]
        
        if let turret = vehicle.defaultProfile.turret {
            defaultProfileCells.append(Cell(name: "Turret", value: String(turret.name), accessoryType: .detailButton) { viewController in
                let turretDetailsViewModel = WITankopediaKit.instantiateTurretDetailsViewModel(for: turret)
                let turretDetailsViewController = WITankopediaKit.instantiateTurretDetailsViewController(with: turretDetailsViewModel)
                viewController.navigationController?.pushViewController(turretDetailsViewController, animated: true)
            })
        }
        
        if let siege = vehicle.defaultProfile.siege {
            defaultProfileCells.append(Cell(name: "Siege", value: String(siege.speedBackward), accessoryType: .detailButton) { viewController in
                let siegeDetailsViewModel = WITankopediaKit.instantiateSiegeDetailsViewModel(for: siege)
                let siegeDetailsViewController = WITankopediaKit.instantiateSiegeDetailsViewController(with: siegeDetailsViewModel)
                viewController.navigationController?.pushViewController(siegeDetailsViewController, animated: true)
            })
        }
        
        if let rapid = vehicle.defaultProfile.rapid {
            defaultProfileCells.append(Cell(name: "Rapid", value: String(rapid.speedBackward), accessoryType: .detailButton) { viewController in
                let rapidDetailsViewModel = WITankopediaKit.instantiateRapidDetailsViewModel(for: rapid)
                let rapidDetailsViewController = WITankopediaKit.instantiateRapidDetailsViewController(with: rapidDetailsViewModel)
                viewController.navigationController?.pushViewController(rapidDetailsViewController, animated: true)
            })
        }
        
        var modulesCells: [Cell] = [
            Cell(name: "Engines", value: String(vehicle.engines.count), accessoryType: .disclosureIndicator) { viewController in
                let modulesDetailsViewModel = WITankopediaKit.instantiateModulesDetailsViewModel(for: vehicle.engines)
                let modulesDetailsViewController = WITankopediaKit.instantiateModulesDetailsViewController(with: modulesDetailsViewModel)
                viewController.navigationController?.pushViewController(modulesDetailsViewController, animated: true)
            },
            Cell(name: "Guns", value: String(vehicle.guns.count), accessoryType: .disclosureIndicator) { viewController in
                let modulesDetailsViewModel = WITankopediaKit.instantiateModulesDetailsViewModel(for: vehicle.guns)
                let modulesDetailsViewController = WITankopediaKit.instantiateModulesDetailsViewController(with: modulesDetailsViewModel)
                viewController.navigationController?.pushViewController(modulesDetailsViewController, animated: true)
            },
            Cell(name: "Provisions", value: String(vehicle.provisions.count), accessoryType: .disclosureIndicator) { viewController in
                let provisionsDetailsViewModel = WITankopediaKit.instantiateProvisionsDetailsViewModel(for: vehicle.provisions)
                let provisionsDetailsViewController = WITankopediaKit.instantiateProvisionsDetailsViewController(with: provisionsDetailsViewModel)
                viewController.navigationController?.pushViewController(provisionsDetailsViewController, animated: true)
            },
            Cell(name: "Radios", value: String(vehicle.radios.count), accessoryType: .disclosureIndicator) { viewController in
                let modulesDetailsViewModel = WITankopediaKit.instantiateModulesDetailsViewModel(for: vehicle.radios)
                let modulesDetailsViewController = WITankopediaKit.instantiateModulesDetailsViewController(with: modulesDetailsViewModel)
                viewController.navigationController?.pushViewController(modulesDetailsViewController, animated: true)
            },
            Cell(name: "Suspensions", value: String(vehicle.suspensions.count), accessoryType: .disclosureIndicator) { viewController in
                let modulesDetailsViewModel = WITankopediaKit.instantiateModulesDetailsViewModel(for: vehicle.suspensions)
                let modulesDetailsViewController = WITankopediaKit.instantiateModulesDetailsViewController(with: modulesDetailsViewModel)
                viewController.navigationController?.pushViewController(modulesDetailsViewController, animated: true)
            }
        ]
        
        if let turrets = vehicle.turrets {
            modulesCells.append(Cell(name: "Turrets", value: String(turrets.count), accessoryType: .disclosureIndicator) { viewController in
                let modulesDetailsViewModel = WITankopediaKit.instantiateModulesDetailsViewModel(for: turrets)
                let modulesDetailsViewController = WITankopediaKit.instantiateModulesDetailsViewController(with: modulesDetailsViewModel)
                viewController.navigationController?.pushViewController(modulesDetailsViewController, animated: true)
            })
        }
        
        sections = [
            Section(title: nil, footer: nil, cells: [
                Cell(name: "BigIcon", value: nil, accessoryType: .none, action: nil)
            ]),
            Section(title: "Profile", footer: nil, cells: profileCells),
            Section(title: "Default Profile", footer: nil, cells: defaultProfileCells),
            Section(title: nil, footer: nil, cells: [
                Cell(name: "Crew", value: String(vehicle.crew.count), accessoryType: .detailButton) { viewController in
                    let crewDetailsViewModel = WITankopediaKit.instantiateCrewDetailsViewModel(for: vehicle.crew)
                    let crewDetailsViewController = WITankopediaKit.instantiateCrewDetailsViewController(with: crewDetailsViewModel)
                    viewController.navigationController?.pushViewController(crewDetailsViewController, animated: true)
                }
            ]),
            Section(title: "Modules", footer: nil, cells: modulesCells)
        ]
    }
}
