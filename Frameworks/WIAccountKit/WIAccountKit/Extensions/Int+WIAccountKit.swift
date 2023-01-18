//
//  Int+WIAccountKit.swift
//  WIAccountKit
//
//  Created by Michael Artes on 04.12.22.
//

import Foundation

extension Int {
    var asDate: String {
        let date = Date(timeIntervalSince1970: Double(self))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        return formatter.string(from: date)
    }
}
