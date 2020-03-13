//
//  MissingsViewController.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 10/01/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import UIKit

class MissingsViewController: UIViewController {
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
extension MissingsViewController {
    fileprivate func setupUI() {
        self.navigationItem.title = "Missings"
        
        // If there is bottom Nav it will give -90 padding from bottom.
        var btnBottom: CGFloat = -50
        if let tabBar = self.tabBarController {
            tabBar.navigationItem.title = "Missings"
            btnBottom = -90
        }
        
        let btn = FloatButton(controller: self, spaceBottom: btnBottom)
        btn.buttonTapped = {
            let vc = STORYBOARD.instantiateViewController(withIdentifier: "PostMissings")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
    }
}
// MARK: - TableView Delegate And DataSource
extension MissingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "missingCell")
        return cell!
    }
    
    
}


