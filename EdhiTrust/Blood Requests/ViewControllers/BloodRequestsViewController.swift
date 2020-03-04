//
//  BloodRequestsViewController.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 07/01/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//
//
import UIKit

class BloodRequestsViewController: UIViewController {
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
extension BloodRequestsViewController {
    fileprivate func setupUI() {
        self.navigationItem.title = "Blood Requests"
        
        let btn = FloatButton(controller: self)
        btn.buttonTapped = {
            let vc = STORYBOARD.instantiateViewController(withIdentifier: "PostBloodRequest")
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
extension BloodRequestsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestCell")
        return cell!
    }
    
    
}
// MARK: - TableViewCell
class RequestCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var bloodGroup: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var photo: UIImageView!
     @IBOutlet weak var callBtn: UIButton!
    override func awakeFromNib() {
        photo.roundCorner(radius: 10)
        callBtn.corners(radius: 10)
    }
}
