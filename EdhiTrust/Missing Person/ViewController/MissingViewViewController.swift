//
//  MissingViewViewController.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 18/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import UIKit

class MissingViewViewController: UIViewController {

    // MARK: - Interface Outlets
    @IBOutlet weak var missingImageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var from: UILabel!
    @IBOutlet weak var fullAddress: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var missingFrom: UILabel!
    @IBOutlet weak var missingDate: UILabel!
    @IBOutlet weak var callBtn: UIButton!
    
    // MARK: - Properties
    var missing: MissingModel!
    
    // MARK: - ViewControllers life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    // MARK: - Interface Actions
    @IBAction func callBtnClicked(_ sender: UIButton) {
        if let missing = self.missing {
            missing.phoneNumber.makeACall()
        }
    }
}
// MARK: - Private Methods
extension MissingViewViewController {
    fileprivate func setupUI() {
        self.navigationItem.title = "Missing Details"
        if let missing = self.missing {
            self.updateUI(missing: missing)
        }
    }
    fileprivate func updateUI(missing: MissingModel) {
        name.text = missing.missingName
        from.text = missing.city
        fullAddress.text = missing.address
        status.text = missing.missingStatus
        age.text = missing.age
        gender.text = missing.gender
        missingFrom.text = missing.dissappearedCity
        missingDate.text = missing.disappearedDate
        missingImageView.sd_setImage(with: URL(string: missing.imageURL))
    }
}
