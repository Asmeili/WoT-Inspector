//
//  DiscoverChipCell.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 06.12.22.
//

import Combine
import UIKit
import WICoreUIKit

class DiscoverChipCell: UICollectionViewCell, Reusable, DiscoverCell {
    @IBOutlet private weak var paddingView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    private var subscribers = Set<AnyCancellable>()
    func setup(for item: DiscoverItem, in section: Int, with viewModel: TankopediaDiscoverViewModel) {
        subscribers.removeAll()
        paddingView.layer.cornerRadius = 20
        nameLabel.text = item.name
        
        switch section {
        case 1:
            viewModel.nation
                .receive(on: DispatchQueue.main)
                .sink { nation in
                    if (item.value == "All2" && nation == nil) || (item.value == nation?.rawValue) {
                        self.selectedStyle()
                    } else {
                        self.unselectedStyle()
                    }
                }
                .store(in: &subscribers)
        case 2:
            viewModel.type
                .receive(on: DispatchQueue.main)
                .sink { type in
                    if (item.value == "All3" && type == nil) || (item.value == type?.rawValue) {
                        self.selectedStyle()
                    } else {
                        self.unselectedStyle()
                    }
                }
                .store(in: &subscribers)
        default:
            viewModel.tier
                .receive(on: DispatchQueue.main)
                .sink { tier in
                    if (item.value == "All1" && tier == nil) || (Int(item.value) == tier) {
                        self.selectedStyle()
                    } else {
                        self.unselectedStyle()
                    }
                }
                .store(in: &subscribers)
        }
    }
    
    private func selectedStyle() {
        nameLabel.textColor = .systemGray5
        paddingView.backgroundColor = .label
    }
    
    private func unselectedStyle() {
        nameLabel.textColor = .label
        paddingView.backgroundColor = .systemGray5
    }
}
