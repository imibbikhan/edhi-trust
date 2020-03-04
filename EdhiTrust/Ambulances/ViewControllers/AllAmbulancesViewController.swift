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
    
    // MARK: - ViewControllers life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        
    }
    
    
}
// MARK: - Private Methods
extension AllAmbulancesViewController {
    fileprivate func setupUI() {
        
    }
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
    }
}
// MARK: - TableView Delegate And DataSource
extension AllAmbulancesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell")
        return cell!
    }
    
    
}


