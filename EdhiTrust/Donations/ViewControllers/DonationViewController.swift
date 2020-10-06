//
//  DonationViewController.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 04/10/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import UIKit
import PKHUD
class DonationViewController: UIViewController {

    // MARK: - Interface Outlets
    @IBOutlet weak var contactNumber: IconTextFieldView!
    @IBOutlet weak var cityName: IconTextFieldView!
    @IBOutlet weak var estimatedCost: IconTextFieldView!
    @IBOutlet weak var address: IconTextFieldView!
    
    @IBOutlet weak var postDonateItemBtn: UIButton!
    
    
    // MARK: - Properties
    var presenter: DonatePresenter!
    
    // MARK: - ViewControllers life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        
        presenter = DonatePresenter()
        presenter.delegate = self
        
    }
    // MARK: - Interface Actions
    @IBAction func donateItemClicked(_ sender: UIButton) {
        let number = contactNumber.field.text ?? ""
        let city = cityName.field.text ?? ""
        let address2 = address.field.text ?? ""
        let cost = estimatedCost.field.text ?? ""
        
        HUD.show(.progress)
        self.presenter.postDonation(item: DonationModel(contactNumber: number, estimatedCost: cost, city: city, address: address2))
    }
}
// MARK: - Private Methods
extension DonationViewController {
    fileprivate func setupUI() {
        self.navigationItem.title = "Donate Item"
        contactNumber.icon.image = UIImage(named: "phone")
        contactNumber.field.placeholder = "Phone Number"
        cityName.icon.image = UIImage(named: "pin2")
        cityName.field.placeholder = "City Name"
        estimatedCost.icon.image = UIImage(named: "pin2")
        estimatedCost.field.placeholder = "300"
        address.icon.image = UIImage(named: "address")
        address.field.placeholder = "Full address"
        postDonateItemBtn.stylePrimaryBtn()
    }
}
// MARK: - Donated Items Delegate
extension DonationViewController: DonationDelegate {
    func donationPosted() {
        DispatchQueue.main.async {
            HUD.flash(.labeledSuccess(title: "Success", subtitle: "Item is donated"), delay: 2)
            
            self.contactNumber.field.text = ""
            self.cityName.field.text = ""
            self.estimatedCost.field.text = ""
            self.address.field.text = ""
        }
    }
    
    func error(message: String) {
        HUD.hide()
        PopUp.shared.show(view: self, message: message)
    }
    
    
}
