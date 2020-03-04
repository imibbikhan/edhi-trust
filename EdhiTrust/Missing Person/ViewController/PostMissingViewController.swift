//
//  PostMissingViewController.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 12/01/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import UIKit

class PostMissingViewController: UIViewController {
    // MARK: - Interface Outlets
    @IBOutlet weak var missingName: IconTextFieldView!
    @IBOutlet weak var missingAge: IconTextFieldView!
    @IBOutlet weak var fromLocation: IconTextFieldView!
    @IBOutlet weak var dissappearedLocation: IconTextFieldView!
    @IBOutlet weak var missingDate: IconTextFieldView!
    @IBOutlet weak var phoneNumber: IconTextFieldView!
    @IBOutlet weak var fullAddress: IconTextFieldView!
    @IBOutlet weak var postMissingBtn: UIButton!
    
    // MARK: - ViewControllers life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}
// MARK: - Private Methods
extension PostMissingViewController {
    fileprivate func setupUI() {
        
        self.navigationItem.title = "Post Missing"
        
        fromLocation.icon.image = UIImage(named: "pin2")
        dissappearedLocation.icon.image = UIImage(named: "pin2")
        missingAge.icon.image = UIImage(named: "age")
        missingDate.icon.image = UIImage(named: "date")
        fullAddress.icon.image = UIImage(named: "address")
        phoneNumber.icon.image = UIImage(named: "phone")
        postMissingBtn.corners(radius: 8)
        
    }
}
