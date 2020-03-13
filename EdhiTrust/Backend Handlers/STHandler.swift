//
//  STHandler.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 13/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
import Firebase
import UIKit
class STHandler {
    static var shared = STHandler()
    
    func saveImage(image: UIImage, path: String, completion: @escaping ((String,String?)->Void)) {
        
        let imageData = image.jpeg(.medium)
        guard let imageDataa = imageData else {
            completion("", "Image Data error")
            return
        }
        let imageToUpload = FB_ST_REF.child("profile_images/")
        imageToUpload.putData(imageDataa, metadata: nil) { (data, error) in
            if let error = error {
                completion("", error.localizedDescription)
                return
            }
            imageToUpload.downloadURL(completion: { (url, error) in
                if let err = error {
                    completion("", err.localizedDescription)
                    return
                }
                guard let dUrl2 = url else {
                    completion("", "URL downloading error")
                    return
                }
                completion(dUrl2.absoluteString, nil)
            })
        }
    }
}
