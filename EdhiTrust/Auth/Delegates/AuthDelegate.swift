//
//  AuthDelegate.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 06/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
protocol AuthDelegate {
    func verificationCodeSent()
    func phoneNumberConfirmed()
    func profileNotSet()
    func error(message: String)
}
