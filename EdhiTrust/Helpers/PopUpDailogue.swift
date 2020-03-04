//
//  PopUpDailogue.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 06/01/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import UIKit
import PopupDialog
import Foundation
class PopUp {
    public static var shared = PopUp()
    func show(view: UIViewController, message: String) {
//        view.removeAllOverlays()
        let title = "Error"
        let message = message
        // Create the dialog
        let popup = PopupDialog(title: title, message: message)
        
        let cancel = CancelButton(title: "OK") {
            
        }
        cancel.titleColor = EDHI_PRIMARY
        popup.addButtons([cancel])
        view.present(popup, animated: true, completion: nil)
    }
}

class FloatButton: UIView {
    var target: UIViewController
    var buttonTapped: (()->Void)?
    
    var title = UILabel()
    required init(controller: UIViewController){
        target = controller
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
            self.bottomAnchor.constraint(equalTo: target.view.bottomAnchor, constant: -50),
        ])
    }
}

