//
//  AuthPresenter.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 06/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
import Firebase
class AuthPresenter {
    var delegate: AuthDelegate?
    
    func verifyPhone(authModel: AuthModel) {
        guard let delegate = self.delegate else { return }
        
        if !isNumberValid(authModel: authModel) {
            delegate.error(message: "Enter complete phone number, Please.")
            return
        }
        
        PhoneAuthProvider.provider().verifyPhoneNumber(authModel.phoneNumber, uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                delegate.error(message: error.localizedDescription)
                return
            }
            DEFAULTS.set(verificationID, forKey: "authVerificationID")
            delegate.verificationCodeSent()
        }
    }
    func confirmCode(verification: PhoneVerification) {
        guard let delegate = self.delegate else { return }
        
        if !isCodeValid(verification: verification) {
            delegate.error(message: "Enter six digits code, Please.")
            return
        }
        
        guard let id = DEFAULTS.string(forKey: "authVerificationID") else { return }
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: id,
            verificationCode: verification.code)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                delegate.error(message: error.localizedDescription)
                return
            }
            delegate.phoneNumberConfirmed()
        }
    }
    fileprivate func isNumberValid(authModel: AuthModel) -> Bool {
        if authModel.phoneNumber.count < 1 {
            return false
        }
        return true
    }
    fileprivate func isCodeValid(verification: PhoneVerification) -> Bool {
        if verification.code.count < 6 {
            return false
        }
        return true
    }
}
