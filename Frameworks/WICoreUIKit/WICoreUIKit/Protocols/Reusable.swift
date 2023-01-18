//
//  Reusable.swift
//  WICoreUIKit
//
//  Created by Michael Artes on 03.12.22.
//

import UIKit

public protocol Reusable: AnyObject {
    static var nib: UINib { get }
    static var nibName: String { get }
}

public extension Reusable {
    static var nib: UINib {
        UINib(nibName: nibName, bundle: Bundle(for: self))
    }
    
    static var nibName: String {
        String(describing: self)
    }
}
