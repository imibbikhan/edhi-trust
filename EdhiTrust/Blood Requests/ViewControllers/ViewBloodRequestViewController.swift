//
//  ViewBloodRequestViewController.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 13/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import UIKit

class ViewBloodRequestViewController: UIViewController {

    // MARK: - Interface Outlets
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var bloodFor: UILabel!
    @IBOutlet weak var cityRefer: UILabel!
    @IBOutlet weak var fullAddress: UILabel!
    @IBOutlet weak var requestType: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var bigTitleBlood: UILabel!
    @IBOutlet weak var smallTitleBlood: UILabel!
    @IBOutlet weak var callBtn: UIButton!
    
    // MARK: - Properties
    var bloodRequest: BloodRequestModel!
    
    // MARK: - ViewControllers life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    // MARK: - Interface Actions
    @IBAction func callBtnClicked(_ sender: UIButton) {
        
    }
}
// MARK: - Properties
extension ViewBloodRequestViewController {
    fileprivate func setupUI() {
        self.navigationItem.title = "Request Details"
        backView.backgroundColor = BLOOD_COLOR
        callBtn.setupLightBtn()
        
        if let request = bloodRequest {
            self.updateUI(request: request)
        }
    }
    fileprivate func updateUI(request: BloodRequestModel) {
        bloodFor.text = request.bloodFor
        cityRefer.text = request.referCity
        fullAddress.text = request.fullAddress
        age.text = request.age
        gender.text = request.gender
        requestType.text = request.requestType
        bigTitleBlood.text = request.bloodGroup
        smallTitleBlood.text = request.bloodGroup
    }
}
