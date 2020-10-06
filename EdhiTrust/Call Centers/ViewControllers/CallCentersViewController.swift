//
//  CallCentersViewController.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 06/10/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import UIKit
import PKHUD
class CallCentersViewController: UIViewController {
    // MARK: - Interface Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Properties
    var centers = [CallCenterModel]()
    var filteredCenters = [CallCenterModel]()
    
    
    var presenter: CallCenterPresenter!
    var isFiltering = false
    
    
    // MARK: - ViewControllers life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        
        presenter = CallCenterPresenter()
        presenter.delegate = self
        HUD.show(.progress)
        presenter.getCenters()
    }
    
    
}
// MARK: - Private Methods
extension CallCentersViewController {
    fileprivate func setupUI() {
        self.navigationItem.title = "Call Centers"
        searchBar.delegate = self
    }
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
    }
}
// MARK: - TableView Delegate And DataSource
extension CallCentersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let center = isFiltering ? filteredCenters[indexPath.row] : centers[indexPath.row]
        Navigator.toSingleCenter(center: center, from: self)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredCenters.count : centers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "centerCell") as? CallCenterCell
        cell?.selectionStyle = .none
        let center = isFiltering ? filteredCenters[indexPath.row] : centers[indexPath.row]
        cell?.titleText.text = center.name.capitalized
        return cell!
    }
    
    
}
// MARK: - Search bar delegates
extension CallCentersViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        isFiltering = false
        tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCenters =  centers.filter {
            $0.name.lowercased().prefix(searchText.count) == searchText.lowercased()
        }
        isFiltering = true
        tableView.reloadData()
    }
}
// MARK: - Call Center Delegates
extension CallCentersViewController: CallCenterDelegates {
    func centersFetched(centers: [CallCenterModel]) {
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
class CallCenterCell: UITableViewCell {
    @IBOutlet weak var titleText: UILabel!
}
