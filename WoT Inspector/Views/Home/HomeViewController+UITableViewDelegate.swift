//
//  HomeViewController+UITableViewDelegate.swift
//  WoT Inspector
//
//  Created by Michael Artes on 03.12.22.
//

import UIKit
import WIWargamingIDKit

extension HomeViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            let cell = tableView.cellForRow(at: indexPath) as! WargamingIDHomeCell
            cell.didTap()
            return
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return CGFloat(70)
        }
        return CGFloat(0)
    }
}
