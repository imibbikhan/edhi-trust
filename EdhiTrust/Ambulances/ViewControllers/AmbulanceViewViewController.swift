//
//  AmbulanceViewViewController.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 04/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import UIKit
import CodableFirebase
import FirebaseAuth
class AmbulanceViewViewController: UIViewController {
    // MARK: - Interface Outlets
    @IBOutlet weak var driverName: UILabel!
    @IBOutlet weak var isAvailable: UILabel!
    @IBOutlet weak var onDistance: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var notifyBtn: UIButton!
    @IBOutlet weak var callNowBtn: UIView!
    
    // MARK: - Properties
    var ambulance: Any!
    var phoneNumber = ""
    // MARK: - ViewControllers life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    @IBAction func callClicked(_ sender: UIButton) {
        phoneNumber.makeACall()
    }
    @IBAction func notifyAmbulance(_ sender: UIButton) {
        if let amb = self.ambulance {
            do {
                let decoded = try FirebaseDecoder().decode(AmbulanceModel.self, from: amb)
                let lat = DEFAULTS.double(forKey: "Latitude")
                let long = DEFAULTS.double(forKey: "Longitude")
                let value = ["lati": lat, "longi": long]
                
                DBHandler.shared.postNow(path: "notifications/\(decoded.ambulanceKey)/\(UUID().uuidString)", data: value) { (error) in
                    if let error = error {
                        PopUp.shared.show(view: self, message: error)
                        return
                    }
                    PopUp.shared.show(view: self, message: "Ambulance is notified.")
                }
                
            }catch{
                PopUp.shared.show(view: self, message: error.localizedDescription)
            }
            
        }

    }
    // MARK: - Objc Methods
    @objc func dismissNow() {
        self.dismiss(animated: true) {
            print("will send something...")
        }
    }
}
// MARK: - Private Methods
extension AmbulanceViewViewController {
    fileprivate func setupUI() {
        bottomView.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissNow))
        self.view.addGestureRecognizer(gesture)
        
        notifyBtn.setupLightBtn()
        
        if let amb = self.ambulance {
            do {
                let decoded = try FirebaseDecoder().decode(AmbulanceModel.self, from: amb)
                self.updateUI(ambulance: decoded)
            }catch{
                PopUp.shared.show(view: self, message: error.localizedDescription)
            }
            
        }
    }
    fileprivate func updateUI(ambulance: AmbulanceModel) {
        driverName.text = ambulance.driverName
        isAvailable.text = ambulance.isAvailable == "true" ? "Available" : "Not Available"
        let dist = ambulance.onDistance ?? 0.0
        onDistance.text = "\(Locations.distanceString(distance: dist)) KM"
        phoneNumber = ambulance.phoneNumber
    }

}
