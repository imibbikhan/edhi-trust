//
//  MissingView.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 10/01/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import UIKit
class MissingView: UIView {
    // MARK: - Interface Outlets
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var callBtn: UIButton!
    // MARK: - Properties
    let XIB_NAME = "MissingView"
    
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
        callBtn.layer.borderWidth = 0.2
        callBtn.layer.borderColor = UIColor.lightGray.cgColor
//        callBtn.addShadow()
//        callBtn.corners(radius: 8)
//        userImage.corners(radius: 8)
    }
}
