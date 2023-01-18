//
//  Collection+WICOreUIKit.swift
//  WICoreUIKit
//
//  Created by Michael Artes on 07.12.22.
//

import Foundation

public extension Collection {
    func concat(with separator: String) -> String {
        self.map { String(describing: $0) }.joined(separator: separator)
    }
}
