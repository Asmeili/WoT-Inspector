//
//  Bool+WICoreUIKit.swift
//  WICoreUIKit
//
//  Created by Michael Artes on 07.12.22.
//

import Foundation

public extension Bool {
    func readable() -> String {
        if self {
            return "Yes"
        }
        return "No"
    }
}
