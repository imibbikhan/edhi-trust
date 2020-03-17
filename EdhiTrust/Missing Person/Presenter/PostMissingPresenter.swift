//
//  PostMissingPresenter.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 15/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
import UIKit
import CodableFirebase
class PostMissingPresenter {
    var delegate: PostMissingDelegate?
    
    func postMissing(missing: MissingModel) {
        guard let delegate = self.delegate else { return }
        do {
            let path = "missing_requests/\(missing.missingKey)"
            let data = try FirebaseEncoder().encode(missing)
            DBHandler.shared.postNow(path: path, data: data) { (error) in
                guard let err = error else {
                    delegate.postSuccess()
                    return
                }
                delegate.error(message: err)
                
            }
        }catch{
            delegate.error(message: error.localizedDescription)
        }
    }
    func uploadMissingImage(image: UIImage, missing: MissingModel) {
        guard let delegate = self.delegate else { return }
        
        if !isValid(missing: missing) {
            delegate.error(message: "All the inputs are required.")
            return
        }
        
        let autoID = DBHandler.shared.getAutoId()
        STHandler.shared.saveImage(image: image, path: "missing_images/\(autoID).jpg") { (url, error) in
            if let err = error {
                delegate.error(message: err)
                return
            }
            delegate.imageUploaded(url: url)
        }
    }
    func isValid(missing: MissingModel) -> Bool {
        if missing.address.count < 0 && missing.age.count < 0 && missing.city.count < 0 && missing.disappearedDate.count < 0 && missing.dissappearedCity.count < 0 && missing.missingName.count < 0 {
            return false
        }
        if missing.missingStatus == "Select Lost or Found" {
            return false
        }
        if missing.gender == "Select Gender" {
            return false
        }
        return true
    }
}
