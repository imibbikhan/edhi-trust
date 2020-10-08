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
    var requests: [BloodRequestModel]!
    
    // MARK: - ViewControllers life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        requests = [BloodRequestModel]()
        setupUI()
        setupTableView()
        
        
        presenter = BloodRequestsPresenter()
        presenter.delegate = self
        HUD.show(.progress)
        if let _ = tabBarController {
            presenter.getBloodRequests(all: true)
            return
        }
        presenter.getBloodRequests(all: false)
    }
    // MARK: - Objc Methods
    @objc func callNow(sender: UIButton) {
        self.requests[sender.tag].phoneNumber.makeACall()
    }
    @objc func handleLongPress(gesture: UIGestureRecognizer){
        let point = gesture.location(in: tableView)
        let index = tableView.indexPathForRow(at: point)
        guard let indexValue = index else { return }
        if gesture.state == .ended {
            PopUp.shared.showOptions(view: self) { (action) in
                if action {
                    self.presenter.deleteBloodRequest(key: self.requests[indexValue.row].requestKey)
                }else{
                    Navigator.toEditBloodRequest(request: self.requests[indexValue.row], from: self)
                }
            }
        }
    }
    
}
// MARK: - Private Methods
extension BloodRequestsViewController {
    fileprivate func setupUI() {
        self.navigationItem.title = "Your Requests"
        
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
    fileprivate func addGesture(cell: UITableViewCell) {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gesture:)))
        cell.isUserInteractionEnabled = true
        gesture.minimumPressDuration = 1.2
        gesture.delaysTouchesEnded = true
        cell.addGestureRecognizer(gesture)
    }
}
// MARK: - TableView Delegate And DataSource
extension BloodRequestsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Navigator.toViewBloodRequest(request: requests[indexPath.row], from: self)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.requests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestCell") as? RequestCell
        let bloodView = cell?.bloodView
        let request = requests[indexPath.row]
        
        bloodView?.bloodTitle.text = request.bloodGroup
        bloodView?.location.text = request.referCity
        bloodView?.bloodFor.text = request.bloodFor
        
        bloodView?.callBtn.tag = indexPath.row
        bloodView?.callBtn.addTarget(self, action: #selector(callNow(sender:)), for: .touchUpInside)
        if self.tabBarController == nil {
            addGesture(cell: cell!)
        }
        return cell!
    }
    
    
}
// MARK: - BloodRequestsDelegates
extension BloodRequestsViewController: BloodRequestsDelegate {
    func requestsFetched(requests: [BloodRequestModel]) {
        DispatchQueue.main.async {
            HUD.hide()
            self.requests = requests
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
