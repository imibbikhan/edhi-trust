//
//  DatePicker.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 17/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
import SwiftyPickerPopover
class DatePicker {
    static func datePicker(view: UIView, base: UIViewController, picked: @escaping (String)->Void) {
        DatePickerPopover(title: "Date")
            .setSelectedDate(Date())
            .setDoneButton(title: "Done", font: UIFont.systemFont(ofSize: 18), color: UIColor.black, action: { popover, selectedDate in
                picked(selectedDate.readable())
            })
            .setCancelButton(title: "Cancel", font: UIFont.systemFont(ofSize: 18), color: UIColor.black, action: { _, _ in
                picked(Date().readable())
            })
            .appear(originView: view, baseViewController: base)
    }
}
