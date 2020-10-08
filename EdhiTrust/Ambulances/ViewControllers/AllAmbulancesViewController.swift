//
//  AllAmbulancesViewController.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 04/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import UIKit

class AllAmbulancesViewController: UIViewController {
    // MARK: - Interface Outlets
    @IBOutlet weak var tableView: UITableView!
    
    var ambulances: [AmbulanceModel]!
    
    // MARK: - ViewControllers life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        
    }
    // MARK: - Objc Methods
    @objc func callNow(_ sender: UIButton) {
        guard let ambulances = self.ambulances else { return  }
        ambulances[sender.tag].phoneNumber.makeACall()
    }
    
}
// MARK: - Private Methods
extension AllAmbulancesViewController {
    fileprivate func setupUI() {
        self.navigationItem.title = "Ambulances"
    }
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
    }
}
// MARK: - TableView Delegate And DataSource
extension AllAmbulancesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let ambulances = self.ambulances else { return 0 }
        return ambulances.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ambulanceCell") as? AmbulanceCell
        let amb = ambulances[indexPath.row]
        cell?.driverName.text = amb.driverName
        let distance = amb.onDistance ?? 0.0
        cell?.distance.text = "\(Locations.distanceString(distance: distance)) KM Away"
        cell?.availability.text = amb.isAvailable == "true" ? "Available" : "Not Availabe"
        cell?.callBtn.tag = indexPath.row
        cell?.callBtn.addTarget(self, action: #selector(callNow(_:)), for: .touchUpInside)
        
        return cell!
    }
    
    
}
// MARK: - AmbulanceCell
class AmbulanceCell: UITableViewCell {
    @IBOutlet weak var driverName: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var availability: UILabel!
    @IBOutlet weak var callBtn: UIButton!
}
