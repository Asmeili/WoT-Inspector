//
//  UIView+WICoreUIKit.swift
//  WICoreUIKit
//
//  Created by Michael Artes on 03.12.22.
//

import UIKit

public extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self.next
        while parentResponder != nil {
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
            parentResponder = parentResponder?.next
        }
        return nil
    }
}
