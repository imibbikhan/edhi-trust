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
    func showOptions(view: UIViewController, done: @escaping (Bool) -> Void) {
        let popup = PopupDialog(title: "Choose", message: "")
        let buttonOne = DefaultButton(title: "Edit".uppercased(), height: 40, dismissOnTap: false) {
            popup.dismiss {
                done(false)
            }
        }
        
        let buttonTwo = DefaultButton(title: "Delete".uppercased(), height: 40, dismissOnTap: false) {
            popup.dismiss {
                done(true)
            }
        }
        
        let buttonThree = DefaultButton(title: "Cancel".uppercased(), height: 40, dismissOnTap: true) {
            
        }
        buttonOne.titleColor = UIColor.systemBlue
        buttonTwo.titleColor = UIColor.systemRed
        buttonThree.titleColor = UIColor.systemGray
        
        popup.addButtons([buttonOne, buttonTwo, buttonThree])
        view.present(popup, animated: true, completion: nil)
    }
}



