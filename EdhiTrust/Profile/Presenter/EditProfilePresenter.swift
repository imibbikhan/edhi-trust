//
//  EditProfilePresenter.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 13/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
import UIKit
class EditProfilePresenter {
    var delegate: EditProfileDelegate?
    
    func editProfile(profile: ProfileModel.EditProfile) {
        guard let delegate = self.delegate else { return }
        
        if !isValid(profile: profile) {
            delegate.error(message: "All the inputs are required.")
            return
        }
        
        let uid = User.getUid()
        
        STHandler.shared.saveImage(image: profile.photo, path: "profile_images/\(uid)") { (url, error) in
            if let err = error {
                delegate.error(message: err)
                return
            }
            User.setDisplayName(name: profile.displayName)
            User.setPhotoURL(url: url)
            DBHandler.shared.editProfile(data: ["email": profile.email, "display_name": profile.displayName, "photo_url": url]) { (error) in
                if let err = error {
                    delegate.error(message: err)
                    return
                }
                delegate.success()
            }
            
        }
       
    }
    fileprivate func isValid(profile: ProfileModel.EditProfile) -> Bool {
        if profile.displayName.count < 1 && profile.email.count < 1 {
            return false
        }
        return true
    }
}
