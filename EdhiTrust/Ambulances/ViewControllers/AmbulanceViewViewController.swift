//
//  AmbulanceViewViewController.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 04/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import UIKit
class AmbulanceViewViewController: UIViewController {
    // MARK: - Interface Outlets
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var notifyBtn: UIView!
    @IBOutlet weak var callNowBtn: UIView!
    // MARK: - ViewControllers life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
        
        notifyBtn.layer.borderWidth = 0.2
        notifyBtn.layer.borderColor = UIColor.lightGray.cgColor
        
        
    }

}
