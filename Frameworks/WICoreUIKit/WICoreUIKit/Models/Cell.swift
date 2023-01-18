//
//  Cell.swift
//  WICoreUIKit
//
//  Created by Michael Artes on 04.12.22.
//

import UIKit

public struct Cell {
    public let name: String
    public let value: String?
    public let accessoryType: UITableViewCell.AccessoryType
    public let action: ((UITableViewController) -> Void)?
    public init(name: String, value: String?, accessoryType: UITableViewCell.AccessoryType, action: ((UITableViewController) -> Void)?) {
        self.name = name
        self.value = value
        self.accessoryType = accessoryType
        self.action = action
    }
    
    public init(name: String) {
        self.init(name: name, value: nil, accessoryType: .none, action: nil)
    }
    
    public init(name: String, value: String?) {
        self.init(name: name, value: value, accessoryType: .none, action: nil)
    }
    
    public init(name: String, value: String?, accessoryType: UITableViewCell.AccessoryType) {
        self.init(name: name, value: value, accessoryType: accessoryType, action: nil)
    }
}
