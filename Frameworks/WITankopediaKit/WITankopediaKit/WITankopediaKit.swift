//
//  WITankopediaKit.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 04.12.22.
//

import UIKit
import WICoreKit
import WICoreUIKit

public enum WITankopediaKit {
    
    // MARK: Services
    
    private static var apiService: ApiService!
    public static var tankopediaService: TankopediaService!
    public static func setApiService(_ apiService: ApiService) {
        self.apiService = apiService
        self.tankopediaService = TankopediaService(apiService)
    }
    
    // MARK: Tankopedia Discover
    
    public static func instantiateTankopediaDiscoverViewModel() -> TankopediaDiscoverViewModel {
        TankopediaDiscoverViewModel(tankopediaService)
    }
    
    public static func instantiateTankopediaDiscoverViewController(with viewModel: TankopediaDiscoverViewModel) -> TankopediaDiscoverViewController {
        let tankopediaDiscoverViewController = TankopediaDiscoverViewController()
        tankopediaDiscoverViewController.viewModel = viewModel
        return TabBarFactory.viewController(from: tankopediaDiscoverViewController)
    }
    
    // MARK: Vehicle Details
    
    public static func instantiateVehicleDetailsViewModel(for tankId: Int) -> VehicleDetailsViewModel {
        VehicleDetailsViewModel(tankopediaService, for: tankId)
    }
    
    public static func instantiateVehicleDetailsViewModel(for vehicle: Vehicle) -> VehicleDetailsViewModel {
        VehicleDetailsViewModel(tankopediaService, for: vehicle)
    }
    
    public static func instantiateVehicleDetailsViewController(with viewModel: VehicleDetailsViewModel) -> VehicleDetailsViewController {
        let storyboard = UIStoryboard(name: "VehicleDetailsView", bundle: Bundle(for: VehicleDetailsViewController.self))
        let vehicleDetailsViewController = storyboard.instantiateViewController(withIdentifier: "VehicleDetailsViewController") as! VehicleDetailsViewController
        vehicleDetailsViewController.viewModel_ = viewModel
        return TabBarFactory.viewController(from: vehicleDetailsViewController)
    }
    
    // MARK: Ammo Details
    
    static func instantiateAmmoDetailsViewModel(for ammo: [VehicleAmmo]) -> AmmoDetailsViewModel {
        AmmoDetailsViewModel(for: ammo)
    }
    
    static func instantiateAmmoDetailsViewController(with viewModel: AmmoDetailsViewModel) -> AmmoDetailsViewController {
        let storyboard = UIStoryboard(name: "AmmoDetailsView", bundle: Bundle(for: AmmoDetailsViewController.self))
        let ammoDetailsViewController = storyboard.instantiateViewController(withIdentifier: "AmmoDetailsViewController") as! AmmoDetailsViewController
        ammoDetailsViewController.viewModel_ = viewModel
        return TabBarFactory.viewController(from: ammoDetailsViewController)
    }
    
    // MARK: Armor Details
    
    static func instantiateArmorDetailsViewModel(for armor: VehicleArmor) -> ArmorDetailsViewModel {
        ArmorDetailsViewModel(for: armor)
    }
    
    static func instantaiteArmorDetailsViewController(with viewModel: ArmorDetailsViewModel) -> ArmorDetailsViewController {
        let storyboard = UIStoryboard(name: "ArmorDetailsView", bundle: Bundle(for: ArmorDetailsViewController.self))
        let armorDetailsViewController = storyboard.instantiateViewController(withIdentifier: "ArmorDetailsViewController") as! ArmorDetailsViewController
        armorDetailsViewController.viewModel_ = viewModel
        return TabBarFactory.viewController(from: armorDetailsViewController)
    }
    
    // MARK: Engine Details
    
    static func instantiateEngineDetailsViewModel(for engine: VehicleEngine) -> EngineDetailsViewModel {
        EngineDetailsViewModel(for: engine)
    }
    
    static func instantiateEngineDetailsViewController(with viewModel: EngineDetailsViewModel) -> EngineDetailsViewController {
        let storyboard = UIStoryboard(name: "EngineDetailsView", bundle: Bundle(for: EngineDetailsViewController.self))
        let engineDetailsViewController = storyboard.instantiateViewController(withIdentifier: "EngineDetailsViewController") as! EngineDetailsViewController
        engineDetailsViewController.viewModel_ = viewModel
        return TabBarFactory.viewController(from: engineDetailsViewController)
    }
    
    // MARK: Gun Details
    
    static func instantiateGunDetailsViewModel(for gun: VehicleGun) -> GunDetailsViewModel {
        GunDetailsViewModel(for: gun)
    }
    
    static func instantiateGunDetailsViewController(with viewModel: GunDetailsViewModel) -> GunDetailsViewController {
        let storyboard = UIStoryboard(name: "GunDetailsView", bundle: Bundle(for: GunDetailsViewController.self))
        let gunDetailsViewController = storyboard.instantiateViewController(withIdentifier: "GunDetailsViewController") as! GunDetailsViewController
        gunDetailsViewController.viewModel_ = viewModel
        return TabBarFactory.viewController(from: gunDetailsViewController)
    }
    
    // MARK: Radio Details
    
    static func instantiateRadioDetailsViewModel(for radio: VehicleRadio) -> RadioDetailsViewModel {
        RadioDetailsViewModel(for: radio)
    }
    
    static func instantiateRadioDetailsViewController(with viewModel: RadioDetailsViewModel) -> RadioDetailsViewController {
        let storyboard = UIStoryboard(name: "RadioDetailsView", bundle: Bundle(for: RadioDetailsViewController.self))
        let radioDetailsViewController = storyboard.instantiateViewController(withIdentifier: "RadioDetailsViewController") as! RadioDetailsViewController
        radioDetailsViewController.viewModel_ = viewModel
        return TabBarFactory.viewController(from: radioDetailsViewController)
    }
    
    // MARK: Suspension Details
    
    static func instantiateSuspensionDetailsViewModel(for suspension: VehicleSuspension) -> SuspensionDetailsViewModel {
        SuspensionDetailsViewModel(for: suspension)
    }
    
    static func instantiateSuspensionDetailsViewController(with viewModel: SuspensionDetailsViewModel) -> SuspensionDetailsViewController {
        let storyboard = UIStoryboard(name: "SuspensionDetailsView", bundle: Bundle(for: SuspensionDetailsViewController.self))
        let suspensionDetailsViewController = storyboard.instantiateViewController(withIdentifier: "SuspensionDetailsViewController") as! SuspensionDetailsViewController
        suspensionDetailsViewController.viewModel_ = viewModel
        return TabBarFactory.viewController(from: suspensionDetailsViewController)
    }
    
    // MARK: Turret Details
    
    static func instantiateTurretDetailsViewModel(for turret: VehicleTurret) -> TurretDetailsViewModel {
        TurretDetailsViewModel(for: turret)
    }
    
    static func instantiateTurretDetailsViewController(with viewModel: TurretDetailsViewModel) -> TurretDetailsViewController {
        let storyboard = UIStoryboard(name: "TurretDetailsView", bundle: Bundle(for: TurretDetailsViewController.self))
        let turretDetailsViewController = storyboard.instantiateViewController(withIdentifier: "TurretDetailsViewController") as! TurretDetailsViewController
        turretDetailsViewController.viewModel_ = viewModel
        return TabBarFactory.viewController(from: turretDetailsViewController)
    }
    
    // MARK: Siege Details
    
    static func instantiateSiegeDetailsViewModel(for siege: VehicleSiege) -> SiegeDetailsViewModel {
        SiegeDetailsViewModel(for: siege)
    }
    
    static func instantiateSiegeDetailsViewController(with viewModel: SiegeDetailsViewModel) -> SiegeDetailsViewController {
        let storyboard = UIStoryboard(name: "SiegeDetailsView", bundle: Bundle(for: SiegeDetailsViewController.self))
        let siegeDetailsViewController = storyboard.instantiateViewController(withIdentifier: "SiegeDetailsViewController") as! SiegeDetailsViewController
        siegeDetailsViewController.viewModel_ = viewModel
        return TabBarFactory.viewController(from: siegeDetailsViewController)
    }
    
    // MARK: Rapid Details
    
    static func instantiateRapidDetailsViewModel(for rapid: VehicleRapid) -> RapidDetailsViewModel {
        RapidDetailsViewModel(for: rapid)
    }
    
    static func instantiateRapidDetailsViewController(with viewModel: RapidDetailsViewModel) -> RapidDetailsViewController {
        let storyboard = UIStoryboard(name: "RapidDetailsView", bundle: Bundle(for: RapidDetailsViewController.self))
        let rapidDetailsViewController = storyboard.instantiateViewController(withIdentifier: "RapidDetailsViewController") as! RapidDetailsViewController
        rapidDetailsViewController.viewModel_ = viewModel
        return TabBarFactory.viewController(from: rapidDetailsViewController)
    }
    
    // MARK: Crew Details
    
    static func instantiateCrewDetailsViewModel(for crew: [VehicleCrew]) -> CrewDetailsViewModel {
        CrewDetailsViewModel(for: crew)
    }
    
    static func instantiateCrewDetailsViewController(with viewModel: CrewDetailsViewModel) -> CrewDetailsViewController {
        let storyboard = UIStoryboard(name: "CrewDetailsView", bundle: Bundle(for: CrewDetailsViewController.self))
        let crewDetailsViewController = storyboard.instantiateViewController(withIdentifier: "CrewDetailsViewController") as! CrewDetailsViewController
        crewDetailsViewController.viewModel_ = viewModel
        return TabBarFactory.viewController(from: crewDetailsViewController)
    }
    
    // MARK: Modules Details
    
    static func instantiateModulesDetailsViewModel(for moduleIds: [Int]) -> ModulesDetailsViewModel {
        ModulesDetailsViewModel(tankopediaService, for: moduleIds)
    }
    
    static func instantiateModulesDetailsViewController(with viewModel: ModulesDetailsViewModel) -> ModulesDetailsViewController {
        let storyboard = UIStoryboard(name: "ModulesDetailsView", bundle: Bundle(for: ModulesDetailsViewController.self))
        let modulesDetailsViewController = storyboard.instantiateViewController(withIdentifier: "ModulesDetailsViewController") as! ModulesDetailsViewController
        modulesDetailsViewController.viewModel_ = viewModel
        return TabBarFactory.viewController(from: modulesDetailsViewController)
    }
    
    // MARK: Module Details
    
    static func instantiateModuleDetailsViewModel(for module: Module) -> ModuleDetailsViewModel {
        ModuleDetailsViewModel(for: module)
    }
    
    static func instantiateModuleDetailsViewController(with viewModel: ModuleDetailsViewModel) -> ModuleDetailsViewController {
        let storyboard = UIStoryboard(name: "ModuleDetailsView", bundle: Bundle(for: ModuleDetailsViewController.self))
        let moduleDetailsViewController = storyboard.instantiateViewController(withIdentifier: "ModuleDetailsViewController") as! ModuleDetailsViewController
        moduleDetailsViewController.viewModel_ = viewModel
        return TabBarFactory.viewController(from: moduleDetailsViewController)
    }
    
    // MARK: Provisions Details
    
    static func instantiateProvisionsDetailsViewModel(for provisionIds: [Int]) -> ProvisionsDetailsViewModel {
        ProvisionsDetailsViewModel(tankopediaService, for: provisionIds)
    }
    
    static func instantiateProvisionsDetailsViewController(with viewModel: ProvisionsDetailsViewModel) -> ProvisionsDetailsViewController {
        let storyboard = UIStoryboard(name: "ProvisionsDetailsView", bundle: Bundle(for: ProvisionsDetailsViewController.self))
        let provisionsDetailsViewController = storyboard.instantiateViewController(withIdentifier: "ProvisionsDetailsViewController") as! ProvisionsDetailsViewController
        provisionsDetailsViewController.viewModel_ = viewModel
        return provisionsDetailsViewController
    }
    
    // MARK: Provision Details
    
    static func instantiateProvisionDetailsViewModel(for provision: Provision) -> ProvisionDetailsViewModel {
        ProvisionDetailsViewModel(for: provision)
    }
    
    static func instantiateProvisionDetailsViewController(with viewModel: ProvisionDetailsViewModel) -> ProvisionDetailsViewController {
        let storyboard = UIStoryboard(name: "ProvisionDetailsView", bundle: Bundle(for: ProvisionDetailsViewController.self))
        let provisionDetailsViewController = storyboard.instantiateViewController(withIdentifier: "ProvisionDetailsViewController") as! ProvisionDetailsViewController
        provisionDetailsViewController.viewModel_ = viewModel
        return TabBarFactory.viewController(from: provisionDetailsViewController)
    }
}
