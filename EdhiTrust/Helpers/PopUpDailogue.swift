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



