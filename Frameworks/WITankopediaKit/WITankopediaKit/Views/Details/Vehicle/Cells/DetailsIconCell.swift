//
//  DetailsIconCell.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 07.12.22.
//

import UIKit
import WICoreUIKit

class DetailsIconCell: UITableViewCell, Reusable {
    @IBOutlet private weak var iconView: UIImageView!
    
    func setup(for imageUrl: String) {
        backgroundColor = .systemGroupedBackground
        
        let url = URL(string: imageUrl.replacingOccurrences(of: "http", with: "https"))!
        iconView.downloaded(from: url)
    }
}
