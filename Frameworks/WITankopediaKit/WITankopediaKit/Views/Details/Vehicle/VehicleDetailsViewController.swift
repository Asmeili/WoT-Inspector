//
//  VehicleDetailsViewController.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 07.12.22.
//

import Combine
import UIKit
import WICoreUIKit

public class VehicleDetailsViewController: WITableViewController, TabBarItem {
    public static let title = "Vehicle Details"
    public static let image = UIImage(systemName: "car.side.fill")
    
    override public var viewModel: WITableViewModel? {
        get { return viewModel_ }
        set { }
    }
    var viewModel_: VehicleDetailsViewModel?
    
    private var subscribers = Set<AnyCancellable>()
    public override func viewDidLoad() {
        navigationItem.largeTitleDisplayMode = .never
        tableView.register(DetailsIconCell.nib, forCellReuseIdentifier: DetailsIconCell.nibName)
        
        super.viewDidLoad()
        guard let viewModel_ else { return }
        setup(for: viewModel_)
    }
    
    private func setup(for viewModel: VehicleDetailsViewModel) {
        subscribers.removeAll()
        viewModel.vehicle
            .receive(on: DispatchQueue.main)
            .sink { completion in
                
            } receiveValue: { vehicle in
                guard let vehicle else {
                    self.title = VehicleDetailsViewController.title
                    return
                }
                self.title = "\(vehicle.shortName) Details"
            }
            .store(in: &subscribers)
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let vehicle = viewModel_?.vehicle.value else { return UITableViewCell() }
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailsIconCell.nibName, for: indexPath) as! DetailsIconCell
            cell.setup(for: vehicle.images.bigIcon)
            return cell
        default:
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
}
