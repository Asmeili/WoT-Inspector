//
//  DiscoverVehicleCell.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 06.12.22.
//

import UIKit
import WICoreUIKit

class DiscoverVehicleCell: UICollectionViewListCell, Reusable, DiscoverCell {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var tierLabel: UILabel!
    @IBOutlet private weak var nationLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    
    func setup(for item: DiscoverItem, in section: Int, with viewModel: TankopediaDiscoverViewModel) {
        accessories = [.disclosureIndicator()]
        
        guard let vehicle = item.vehicle else {
            fatalError("Vehicle Cell needs a vehicle (duh)")
        }
        
        let url = URL(string: vehicle.images.bigIcon.replacingOccurrences(of: "http", with: "https"))!
        imageView.downloaded(from: url)
        
        titleLabel.text = vehicle.name
        tierLabel.text = "Tier \(vehicle.tier)"
        nationLabel.text = vehicle.nation.readable().rawValue
        typeLabel.text = vehicle.type.readable().rawValue
        
        if vehicle.isPremium {
            titleLabel.textColor = .systemYellow
        } else {
            titleLabel.textColor = .label
        }
        
        if let priceGold = vehicle.priceGold, priceGold > 0 {
            priceLabel.text = "\(priceGold) Gold"
            priceLabel.textColor = .systemYellow
        } else if let priceCredit = vehicle.priceCredit, (priceCredit > 0 || vehicle.tier == 1) {
            priceLabel.text = "\(vehicle.priceCredit ?? 0) Credits"
            priceLabel.textColor = .black
        } else {
            priceLabel.text = "Not for sale"
            priceLabel.textColor = .black
        }
    }
}
