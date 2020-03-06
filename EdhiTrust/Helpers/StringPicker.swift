//
//  StringPicker.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 06/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
import UIKit
import SwiftyPickerPopover

class StringPicker {
    static var doneClicked: ((String) -> Void)?
    
    static func showPicker(title: String, choices: [String], base: UIViewController, origin: UIView) {
        StringPickerPopover(title: title, choices: choices)
            .setFont(UIFont.systemFont(ofSize: 18, weight: .semibold))
            .setSelectedRow(0)
            .setDoneButton(action: { (popover, selectedRow, selectedString) in
                StringPicker.doneClicked?(selectedString)
            })
            .setCancelButton(action: { (_, _, _) in print("cancel")}
        )
            .appear(originView: origin, baseViewController: base)
    }
}
