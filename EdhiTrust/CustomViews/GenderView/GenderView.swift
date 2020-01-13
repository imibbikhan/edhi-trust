//
//  GenderView.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 09/01/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import UIKit

class GenderView: UIView {
    // MARK: - Interface Outlets
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var roundedBorderView: UIView!
    // MARK: - Properties
    let XIB_NAME = "GenderView"
    
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
    }
}
