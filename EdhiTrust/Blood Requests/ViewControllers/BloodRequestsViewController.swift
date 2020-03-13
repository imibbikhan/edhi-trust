//
//  BloodRequestsViewController.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 07/01/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//
//
import UIKit
import PKHUD
class BloodRequestsViewController: UIViewController {
    // MARK: - Interface Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var presenter: BloodRequestsPresenter!
    var allMyRequests: [BloodRequestModel]!
    
    // MARK: - ViewControllers life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        allMyRequests = [BloodRequestModel]()
        setupUI()
        setupTableView()
        
        
        presenter = BloodRequestsPresenter()
        presenter.delegate = self
        HUD.show(.progress)
        if let _ = tabBarController {
            presenter.getMyRequests(allRequests: true)
            return
        }
        presenter.getMyRequests(allRequests: false)
    }
    
    
}
// MARK: - Private Methods
extension BloodRequestsViewController {
    fileprivate func setupUI() {
        self.navigationItem.title = "Blood Requests"
        
        // If there is bottom Nav it will give -90 padding from bottom.
        var btnBottom: CGFloat = -50
        if let tabBar = self.tabBarController {
            tabBar.navigationItem.title = "Blood Requests"
            btnBottom = -90
        }
        
        let btn = FloatButton(controller: self, spaceBottom: btnBottom)
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Navigator.toViewBloodRequest(request: allMyRequests[indexPath.row], from: self)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allMyRequests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestCell") as? RequestCell
        let bloodView = cell?.bloodView
        let request = allMyRequests[indexPath.row]
        
        bloodView?.bloodTitle.text = request.bloodGroup
        bloodView?.location.text = request.referCity
        bloodView?.bloodFor.text = request.bloodFor
        return cell!
    }
    
    
}
// MARK: - BloodRequestsDelegates
extension BloodRequestsViewController: BloodRequestsDelegate {
    func requestsFetched(requests: [BloodRequestModel]) {
        DispatchQueue.main.async {
            HUD.hide()
            self.allMyRequests = requests
            self.tableView.reloadData()
        }
    }
    
    func error(message: String) {
        HUD.hide()
        PopUp.shared.show(view: self, message: message)
    }
    
    
}
// MARK: - TableViewCell
class RequestCell: UITableViewCell {
    @IBOutlet weak var bloodView: BloodView!
    override func awakeFromNib() {

    }
}
