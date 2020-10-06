//
//  PostBloodRequestViewController.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 07/01/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import UIKit
import SwiftyPickerPopover
import PKHUD
class PostBloodRequestViewController: UIViewController {
    // MARK: - Interface Outlets
    @IBOutlet weak var bloodFor: IconTextFieldView!
    @IBOutlet weak var cityRefer: IconTextFieldView!
    @IBOutlet weak var fullAddress: IconTextFieldView!
    @IBOutlet weak var age: IconTextFieldView!
    @IBOutlet weak var gender: UIButton!
    @IBOutlet weak var requestType: UIButton!
    @IBOutlet weak var bloodGroup: UIButton!
    @IBOutlet weak var postRequest: UIButton!
    
    // MARK: - Properties
    var bloodRequestModel: BloodRequestModel?
    var presenter: PostBloodRequestPresenter!
    
    // MARK: - ViewControllers life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        presenter = PostBloodRequestPresenter()
        presenter.delegate = self
    }
    // MARK: - Interface Actions
    @IBAction func bloodGroup(sender: UIButton) {
        StringPicker.showPicker(title: "Blood Group", choices: ["B+", "A+", "AB+", "B-", "A-", "O+", "O-"], base: self, origin: sender)
        StringPicker.doneClicked = { title in
            self.bloodGroup.setTitle(title, for: .normal)
        }
    }
    @IBAction func requestFor(sender: UIButton) {
        StringPicker.showPicker(title: "Request Type", choices: ["Reciever", "Donor"], base: self, origin: sender)
        StringPicker.doneClicked = { title in
            self.requestType.setTitle(title, for: .normal)
        }
    }
    @IBAction func gender(sender: UIButton) {
        StringPicker.showPicker(title: "Select Gender", choices: ["Male", "Female", "Other"], base: self, origin: sender)
        StringPicker.doneClicked = { title in
            self.gender.setTitle(title, for: .normal)
        }
    }
    @IBAction func postClicked(sender: UIButton) {
        let bloodFor = self.bloodFor.field.text ?? ""
        let cityRefer = self.cityRefer.field.text ?? ""
        let fullAddress = self.fullAddress.field.text ?? ""
        let age = self.age.field.text ?? ""
        let requestType = self.requestType.titleLabel?.text ?? "Select Request Type"
        let bloodGroup = self.bloodGroup.titleLabel?.text ?? "Select Blood Group"
        let gender = self.gender.titleLabel?.text ?? "Select Gender"
        let phone = User.getPhoneNumber()
        let uid = User.getUid()
        
        var key = DBHandler.shared.getAutoId()
        
        if let model = bloodRequestModel {
            key = model.requestKey
        }
        let bloodRequest = BloodRequestModel(requestKey: key, referCity: cityRefer.lowercased(), gender: gender, bloodGroup: bloodGroup, fullAddress: fullAddress, phoneNumber: phone, age: age, requestType: requestType, bloodFor: bloodFor, userKey: uid)
        HUD.show(.progress)
        presenter.postBloodRequest(request: bloodRequest)
        
    }
}
// MARK: - Private Methods
extension PostBloodRequestViewController {
    fileprivate func setupUI() {
        self.navigationItem.title = "Post Request"
        
        postRequest.corners(radius: 5)
        bloodGroup.narrowShadow()
        requestType.narrowShadow()
        gender.narrowShadow()
        
        age.icon.image = UIImage(named: "age")
        age.field.placeholder = "20"
        age.field.keyboardType = .numberPad
        
        cityRefer.icon.image = UIImage(named: "pin2")
        cityRefer.field.placeholder = "Kohat"
        
        fullAddress.icon.image = UIImage(named: "pin2")
        fullAddress.field.placeholder = "Bannu Road Haji Abad, Jarma, Kohat"
        if let request = bloodRequestModel {
            self.updateUI(request: request)
        }
    }
    fileprivate func updateUI(request: BloodRequestModel) {
        bloodFor.field.text = request.bloodFor
        cityRefer.field.text = request.referCity
        fullAddress.field.text = request.fullAddress
        age.field.text = request.age
        gender.setTitle(request.gender, for: .normal)
        requestType.setTitle(request.requestType, for: .normal)
        bloodGroup.setTitle(request.bloodGroup, for: .normal)
    }
}
// MARK: - PostBloodRequestDelegate
extension PostBloodRequestViewController: PostBloodRequestDelegate {
    func postSuccess() {
        DispatchQueue.main.async {
            HUD.hide()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func error(message: String) {
        HUD.hide()
        PopUp.shared.show(view: self, message: message)
    }
}
