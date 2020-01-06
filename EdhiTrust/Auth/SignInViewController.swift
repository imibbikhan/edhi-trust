//
//  SignInViewController.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 06/01/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import UIKit
import FlagPhoneNumber
class SignInViewController: UIViewController {
    // MARK: - Interface Outlets
    @IBOutlet weak var countryCode: FPNTextField!
    @IBOutlet weak var signInWithNUmBtn: UIButton!
    @IBOutlet weak var halfView: UIView!
    @IBOutlet weak var centerView: RoundShadowView!
    @IBOutlet weak var halfHeight: NSLayoutConstraint!
    
    // MARK: - Properties
    var listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    var phoneNumberText = ""
    
    // MARK: - ViewControllers life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        countryCode.delegate = self
    }

    // MARK: - Interface Actions
    @IBAction func signInWithNumPressed(_ sender: UIButton) {
//        let verify = STORYBOARD.instantiateViewController(withIdentifier: "ConfirmNumber")
//        verify?.phoneNumber = phoneNumberText
//        self.view.window?.rootViewController = verify!
        
    }
}
// MARK: - Private Methods
extension SignInViewController {
    fileprivate func setupUI() {
        self.halfHeight.constant = self.view.frame.height/2
        self.halfView.backgroundColor = EDHI_PRIMARY
        self.signInWithNUmBtn.backgroundColor = EDHI_PRIMARY
        self.signInWithNUmBtn.layer.cornerRadius = 8
        
        // Flag Field
        countryCode.layer.borderColor =  UIColor(hexString: LIGHT_GREY_COLOR).cgColor
        countryCode.layer.borderWidth = 1.0
        countryCode.layer.cornerRadius = 8.0
        countryCode.displayMode = .list
        listController.setup(repository: countryCode.countryRepository)
        listController.didSelect = { [weak self] country in
            self?.countryCode.setFlag(countryCode: country.code)
        }
    }
}
extension SignInViewController: FPNTextFieldDelegate {
    @objc func dismissCountries() {
        listController.dismiss(animated: true, completion: nil)
    }
    func fpnDisplayCountryList() {
        let navigationViewController = UINavigationController(rootViewController: listController)
        
        listController.title = "Countries"
        listController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissCountries))
        
        self.present(navigationViewController, animated: true, completion: nil)
    }
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        print(name, dialCode, code)
    }
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid {
            phoneNumberText = textField.getFormattedPhoneNumber(format: .E164) ?? ""
        }else{
            phoneNumberText = ""
        }
    }
}
