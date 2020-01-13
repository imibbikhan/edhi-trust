//
//  CentersDetailsViewController.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 13/01/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import UIKit

class CentersDetailsViewController: UIViewController {
    // MARK: - Interface Outlets
    @IBOutlet weak var tableView: UITableView!
    var list = ["Khyber PakhtunKhwa", "Punjab", "Sindh", "Baluchistan", "Gilgit Baltistan", "Kashmir"]
    // MARK: - ViewControllers life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    
}
// MARK: - Private Methods
extension CentersDetailsViewController {
    fileprivate func setupUI() {
        self.navigationItem.title = "Centers"
    }
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
    }
}
// MARK: - TableView Delegate And DataSource
extension CentersDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "centerCell") as? CenterCell
        cell?.titleText.text = self.list[indexPath.row]
        return cell!
    }
    
    
}

// MARK: - TableViewCell
class CenterCell: UITableViewCell {
    @IBOutlet weak var titleText: UILabel!
}
