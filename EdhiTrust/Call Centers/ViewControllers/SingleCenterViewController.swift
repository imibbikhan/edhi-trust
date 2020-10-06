//
//  SingleCenterViewController.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 06/10/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import UIKit

class SingleCenterViewController: UIViewController {
    
    // MARK: - Interface Outlets
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var centerName: UILabel!
    @IBOutlet weak var centerAddress: UILabel!
    @IBOutlet weak var centerContact: UILabel!
    
    // MARK: - Properties
    var center: CallCenterModel?
    
    // MARK: - ViewControllers life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCenter()
    }
    // MARK: - Interface Actions
    @IBAction func callNowClicked(_ sender: Any) {
        guard let center = self.center else { return }
        if let url = URL(string: "tel://\(center.number)") {
            UIApplication.shared.open(url)
        }
    }
}
// MARK: - Private Methods
extension SingleCenterViewController{
    fileprivate func setupUI() {
        self.navigationItem.title = "Details"
        callBtn.stylePrimaryBtn()
    }
    fileprivate func setupCenter() {
        guard let center = self.center else { return }
        centerName.text = center.name
        centerAddress.text = center.address
        centerContact.text = center.number
    }
}
