//
//  UITableViewCell+WICoreUIKit.swift
//  WICoreUIKit
//
//  Created by Michael Artes on 03.12.22.
//

import UIKit

public extension UITableViewCell {
    var tableView: UITableView? {
        var view = self.superview
        while (view != nil && (view as? UITableView) == nil) {
            view = view?.superview
        }
        return view as? UITableView
    }
}
