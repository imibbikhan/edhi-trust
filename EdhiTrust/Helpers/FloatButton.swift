//
//  FloatButton.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 06/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
import UIKit
class FloatButton: UIView {
    var spaceBottom: CGFloat
    var target: UIViewController
    var buttonTapped: (()->Void)?
    
    var title = UILabel()
    required init(controller: UIViewController, spaceBottom: CGFloat = -50){
        target = controller
        self.spaceBottom = spaceBottom
        super.init(frame: CGRect.zero)
        self.addSubview(title)
        common()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func common() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.addGestureRecognizer(gesture)
        self.backgroundColor = UIColor.lightGray
        self.layer.cornerRadius = 30
        
        
        title.text = "+"
        title.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        title.center = self.center
        title.textColor = UIColor.white
        setupLayout()
    }
    @objc func tapped() {
        buttonTapped?()
    }
    fileprivate func setupLayout() {
        
        self.target.view.addSubview(self)
        title.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            title.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.heightAnchor.constraint(equalToConstant: 60),
            self.widthAnchor.constraint(equalToConstant: 60),
            self.trailingAnchor.constraint(equalTo: target.view.trailingAnchor, constant: -30),
            self.bottomAnchor.constraint(equalTo: target.view.bottomAnchor, constant: spaceBottom),
        ])
    }
}
