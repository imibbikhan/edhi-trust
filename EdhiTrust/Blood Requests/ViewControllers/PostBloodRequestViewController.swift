//
//  PostBloodRequestViewController.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 07/01/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import UIKit

class PostBloodRequestViewController: UIViewController {

    @IBOutlet weak var bloodFor: IconTextFieldView!
    @IBOutlet weak var cityRefer: IconTextFieldView!
    @IBOutlet var bloodGroups: [UIButton]!
    @IBOutlet weak var postRequest: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}
// MARK: - Private Methods
extension PostBloodRequestViewController {
    fileprivate func setupUI() {
        self.navigationItem.title = "Post Request"
        // rounded corners..
        for btn in bloodGroups {
            btn.corners(radius: btn.layer.frame.height/2)
        }
        postRequest.corners(radius: 8)
    }
}
