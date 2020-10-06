//
//  CentersDetailsViewController.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 13/01/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import UIKit
import PKHUD
class CentersDetailsViewController: UIViewController {
    // MARK: - Interface Outlets
    @IBOutlet weak var tableView: UITableView!
     @IBOutlet weak var searchBar: UISearchBar!
    
    
    // MARK: - Properties
    var centers = [CenterModel]()
    var filteredCenters = [CenterModel]()
    
    var presenter: CenterDetailPresenter!
    var isFiltering = false
    
    // MARK: - ViewControllers life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        
        presenter = CenterDetailPresenter()
        presenter.delegate = self
        HUD.show(.progress)
        presenter.getCentersDetails()
    }
    
    
}
// MARK: - Private Methods
extension CentersDetailsViewController {
    fileprivate func setupUI() {
        self.navigationItem.title = "Centers"
        searchBar.delegate = self
    }
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
    }
}
// MARK: - TableView Delegate And DataSource
extension CentersDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let center = isFiltering ? filteredCenters[indexPath.row] : centers[indexPath.row]
        Navigator.toSingleCenterDetails(center: center, from: self)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredCenters.count : centers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "centerCell") as? CenterCell
        cell?.selectionStyle = .none
        let center = isFiltering ? filteredCenters[indexPath.row] : centers[indexPath.row]
        cell?.titleText.text = center.centerName.capitalized
        return cell!
    }
    
    
}
// MARK: - Search bar delegates
extension CentersDetailsViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        isFiltering = false
        tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCenters =  centers.filter {
            $0.centerName.lowercased().prefix(searchText.count) == searchText.lowercased()
        }
        isFiltering = true
        tableView.reloadData()
    }
}
// MARK: - Center Details Delegates
extension CentersDetailsViewController: CenterDetailDelegates {
    func centersFetched(centers: [CenterModel]) {
        DispatchQueue.main.async {
            HUD.hide()
            self.centers = centers
            self.tableView.reloadData()
        }
    }
    
    func error(message: String) {
        HUD.hide()
        PopUp.shared.show(view: self, message: message)
    }
}
// MARK: - TableViewCell
class CenterCell: UITableViewCell {
    @IBOutlet weak var titleText: UILabel!
}
