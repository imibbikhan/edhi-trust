//
//  DonationDelegate.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 04/10/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
protocol DonationDelegate {
    func donationPosted()
    func error(message: String)
}
