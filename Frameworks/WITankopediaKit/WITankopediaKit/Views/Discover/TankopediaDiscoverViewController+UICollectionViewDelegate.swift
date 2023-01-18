//
//  TankopediaDiscoverViewController+UICollectionViewDelegate.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 06.12.22.
//

import UIKit

extension TankopediaDiscoverViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let viewModel else { return }
        let section = viewModel.sections[indexPath.section]
        let item = section.items[indexPath.item]
        
        switch section.type {
        case .chips:
            switch indexPath.section {
            case 1:
                if item.value == "All2" {
                    viewModel.nation.send(nil)
                } else {
                    guard let nation = VehicleNationInternal(rawValue: item.value) else { return }
                    viewModel.nation.send(nation)
                }
            case 2:
                if item.value == "All3" {
                    viewModel.type.send(nil)
                } else {
                    guard let type = VehicleTypeInternal(rawValue: item.value) else { return }
                    viewModel.type.send(type)
                }
            default:
                if item.value == "All1" {
                    viewModel.tier.send(nil)
                } else {
                    guard let valueInt = Int(item.value) else { return }
                    viewModel.tier.send(valueInt)
                }
            }
        case .results:
            guard let vehicle = item.vehicle else { fatalError("Must provide vehicle to vehicle cell!!!") }
            let vehicleDetailsViewModel = WITankopediaKit.instantiateVehicleDetailsViewModel(for: vehicle)
            let vehicleDetailsViewController = WITankopediaKit.instantiateVehicleDetailsViewController(with: vehicleDetailsViewModel)
            navigationController?.pushViewController(vehicleDetailsViewController, animated: true)
        }
    }
}
