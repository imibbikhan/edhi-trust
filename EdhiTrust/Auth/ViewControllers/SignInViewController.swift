//
//  SignInViewController.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 06/01/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import UIKit
import FlagPhoneNumber
import PKHUD
class SignInViewController: UIViewController {
    // MARK: - Interface Outlets
    @IBOutlet weak var countryCode: FPNTextField!
    @IBOutlet weak var verificationCode: UITextField!
    @IBOutlet weak var signInWithNUmBtn: UIButton!
    @IBOutlet weak var halfView: UIView!
    @IBOutlet weak var centerView: RoundShadowView!
    @IBOutlet weak var halfHeight: NSLayoutConstraint!
    
    // MARK: - Properties
    var listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    var phoneNumberText = ""
    var codeSent = false
    
    var presenter: AuthPresenter!
    
    // MARK: - ViewControllers life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        countryCode.delegate = self
        
        presenter = AuthPresenter()
        presenter.delegate = self
    }
    
    // MARK: - Interface Actions
    @IBAction func signInWithNumPressed(_ sender: UIButton) {
        HUD.show(.progress)
        if !codeSent {
            presenter.verifyPhone(authModel: AuthModel(phoneNumber: phoneNumberText))
        }else{
            presenter.confirmCode(verification: PhoneVerification(code: self.verificationCode.text ?? ""))
        }
        
    }
}
// MARK: - Private Methods
extension SignInViewController {
    fileprivate func setupUI() {
        self.halfHeight.constant = self.view.frame.height/2
        self.signInWithNUmBtn.stylePrimaryBtn()
        self.verificationCode.isHidden = true
        // Flag Field
        countryCode.setFlag(key: .PK)
        countryCode.placeholder = "3332012717"
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
// MARK: - Auth Delegates
extension SignInViewController: AuthDelegate {
    func verificationCodeSent() {
        HUD.hide()
        self.verificationCode.isHidden = false
        self.codeSent = true
    }
    
    func phoneNumberConfirmed() {
        HUD.hide()
        Navigator.setRoot(window: self.view.window ?? UIWindow(), route: Routes.home)
    }
    
    func profileNotSet() {
        HUD.hide()
        Navigator.setRoot(window: self.view.window ?? UIWindow(), route: .editProfile)
    }
    
    func error(message: String) {
        HUD.hide()
        PopUp.shared.show(view: self, message: message)
    }
}
