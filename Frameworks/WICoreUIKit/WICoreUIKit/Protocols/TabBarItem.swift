//
//  TabBarItem.swift
//  WICoreUIKit
//
//  Created by Michael Artes on 03.12.22.
//

import UIKit

public protocol TabBarItem {
    static var title: String { get }
    static var image: UIImage? { get }
}
