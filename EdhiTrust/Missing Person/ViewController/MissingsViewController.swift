//
//  MissingsViewController.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 10/01/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import UIKit
import PKHUD
class MissingsViewController: UIViewController {
    // MARK: - Interface Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var presenter: MissingPresenter!
    var missings: [MissingModel]!
    // MARK: - ViewControllers life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        missings = [MissingModel]()
        
        setupUI()
        setupTableView()
        
        
        presenter = MissingPresenter()
        presenter.delegate = self
        
        HUD.show(.progress)
        if let _ = self.tabBarController {
            presenter.getAllMissings(all: true)
        }else{
            presenter.getAllMissings(all: false)
        }
    }
    
    // MARK: - Objc Methods
    @objc func callNow(sender: UIButton) {
        self.missings[sender.tag].phoneNumber.makeACall()
    }
    @objc func handleLongPress(gesture: UIGestureRecognizer){
        let point = gesture.location(in: tableView)
        let index = tableView.indexPathForRow(at: point)
        guard let indexValue = index else { return }
        if gesture.state == .ended {
            PopUp.shared.showOptions(view: self) { (action) in
                if action {
                    self.presenter.deleteMissingPost(key: self.missings[indexValue.row].missingKey)
                }else{
                    Navigator.toEditMissing(missing: self.missings[indexValue.row], from: self)
                }
            }

        }
    }
}
// MARK: - Private Methods
extension MissingsViewController {
    fileprivate func setupUI() {
        self.navigationItem.title = "Your Missings"
        
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
    fileprivate func addGesture(cell: UITableViewCell) {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gesture:)))
        cell.isUserInteractionEnabled = true
        gesture.minimumPressDuration = 1.2
        gesture.delaysTouchesEnded = true
        cell.addGestureRecognizer(gesture)
    }
}
// MARK: - TableView Delegate And DataSource
extension MissingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Navigator.toViewMissingRequest(missing: missings[indexPath.row], from: self)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return missings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "missingCell") as? MissingCell
        let viewM = cell?.missingView
        let missing = self.missings[indexPath.row]
        
        viewM?.name.text = missing.missingName
        viewM?.status.text = missing.missingStatus
        viewM?.date.text = missing.disappearedDate
        viewM?.userImage.sd_setImage(with: URL(string: missing.imageURL))
        
        viewM?.callBtn.tag = indexPath.row
        viewM?.callBtn.addTarget(self, action: #selector(callNow(sender:)), for: .touchUpInside)
        
        if self.tabBarController == nil {
            addGesture(cell: cell!)
        }
        return cell!
    }
}
// MARK: - MissingDelegate
extension MissingsViewController: MissingDelegate {
    func missingsFetched(missings: [MissingModel]) {
        DispatchQueue.main.async {
            HUD.hide()
            self.missings = missings
            self.tableView.reloadData()
        }
    }
    
    func error(message: String) {
        DispatchQueue.main.async {
            HUD.hide()
            PopUp.shared.show(view: self, message: message)
        }
    }
}
// MARK: - Missing Cell
class MissingCell: UITableViewCell {
    @IBOutlet weak var missingView: MissingView!
}

