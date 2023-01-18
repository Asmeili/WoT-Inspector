//
//  HomeViewController+UITableViewDataSource.swift
//  WoT Inspector
//
//  Created by Michael Artes on 03.12.22.
//

import UIKit
import WIWargamingIDKit

extension HomeViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let wargamingIDHomeCellViewModel = WIWargamingIDKit.instantiateWargamingIDHomeCellViewModel()
            let cell = tableView.dequeueReusableCell(withIdentifier: WargamingIDHomeCell.nibName, for: indexPath) as! WargamingIDHomeCell
            cell.setup(for: wargamingIDHomeCellViewModel)
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
}
