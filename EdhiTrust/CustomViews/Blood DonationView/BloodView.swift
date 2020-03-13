//
//  BloodView.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 03/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import UIKit
class BloodView: UIView {
    // MARK: - Interface Outlets
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var bloodTitle: UILabel!
    @IBOutlet weak var bloodTitle2: UILabel!
    @IBOutlet weak var bloodFor: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var callBtn: UIButton!
    // MARK: - Properties
    let XIB_NAME = "BloodView"
    
    // MARK: - overriders.
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - Mehtods
    func commonInit() {
        let view = Bundle.main.loadNibNamed(XIB_NAME, owner: self, options: nil)![0] as? UIView
        view?.frame = self.bounds
        self.addSubview(view!)
        setupUI()
    }
    func setupUI() {
        callBtn.setupLightBtn()
        backView.backgroundColor = BLOOD_COLOR
    }
}
