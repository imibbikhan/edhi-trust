//
//  IconTextFieldView.swift
//  Reserve
//
//  Created by Ibbi Khan on 10/12/19.
//  Copyright © 2019 Ibbi Khan. All rights reserved.
//

import UIKit

class IconTextFieldView: UIView {
    // MARK: - Interface Outlets
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var roundedBorderView: UIView!
    // MARK: - Properties
    let XIB_NAME = "IconTextFieldView"
    
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
        self.setupViews()
    }
    func setupViews() {
        roundedBorderView.layer.cornerRadius = 5.0
        roundedBorderView.layer.borderColor = UIColor(hexString: LIGHT_GREY_COLOR).cgColor
        roundedBorderView.layer.borderWidth = 1.0
    }
}
