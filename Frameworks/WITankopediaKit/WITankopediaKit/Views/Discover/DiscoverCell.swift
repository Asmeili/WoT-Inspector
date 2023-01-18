//
//  DiscoverCell.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 06.12.22.
//

import WICoreUIKit

protocol DiscoverCell: Reusable {
    func setup(for item: DiscoverItem, in section: Int, with viewModel: TankopediaDiscoverViewModel)
}
