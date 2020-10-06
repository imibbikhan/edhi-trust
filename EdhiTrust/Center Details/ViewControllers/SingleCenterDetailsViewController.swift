//
//  SingleCenterDetailsViewController.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 06/10/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import UIKit

class SingleCenterDetailsViewController: UIViewController {
    // MARK: - Interface Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var centerDetails: CenterModel?
    var details = [[CenterDetail]]()
    
    // MARK: - ViewControllers life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupDetails()
    }
}
// MARK: - Private Methods
extension SingleCenterDetailsViewController {
    fileprivate func setupUI() {
        self.navigationItem.title = "Center Details"
    }
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
    }
    fileprivate func setupDetails() {
        guard let  details = centerDetails else { return }
        let generalDetails = [
            CenterDetail(keyTitle: "Children", valueTitle: details.totalChildren),
            CenterDetail(keyTitle: "Widows", valueTitle: details.totalWidows),
            CenterDetail(keyTitle: "Orphans", valueTitle: details.totalOrphans)
        ]
        let bloodDetails = [
            CenterDetail(keyTitle: "A+", valueTitle: details.aPositive),
            CenterDetail(keyTitle: "A-", valueTitle: details.aNegative),
            CenterDetail(keyTitle: "B+", valueTitle: details.bPositive),
            CenterDetail(keyTitle: "B-", valueTitle: details.bNegative),
            CenterDetail(keyTitle: "AB", valueTitle: details.abPositive),
            CenterDetail(keyTitle: "O+", valueTitle: details.oPositive),
            CenterDetail(keyTitle: "O-", valueTitle: details.oNegative)
        ]
        self.details.append(generalDetails)
        self.details.append(bloodDetails)
        self.tableView.reloadData()
    }
}
// MARK: - TableView Delegate And DataSource
extension SingleCenterDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let name = centerDetails?.centerName ?? "Center Name"
        return section == 0 ? name : "Available Blood"
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return details.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as? CenterDetailCell
        let center = details[indexPath.section][indexPath.row]
        cell?.keyTitle.text = center.keyTitle
        cell?.valueTitle.text = center.valueTitle
        return cell!
    }
}
// MARK: - TableViewCell
class CenterDetailCell: UITableViewCell {
    @IBOutlet weak var keyTitle: UILabel!
    @IBOutlet weak var valueTitle: UILabel!
}

