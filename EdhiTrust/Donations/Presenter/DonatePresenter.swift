//
//  DonatePresenter.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 04/10/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
class DonatePresenter {
    var delegate: DonationDelegate?
    
    func postDonation(item: DonationModel) {
        if !isValid(item: item) {
            delegate?.error(message: "Item data is required.")
            return
        }
        
        DBHandler.shared.addDonatedItem(item: item) { (error) in
            if let error = error {
                self.delegate?.error(message: error)
                return
            }
            self.delegate?.donationPosted()
        }
    }
    func isValid(item: DonationModel)->Bool {
        if item.city.count == 0 || item.address.count == 0 || item.contactNumber.count == 0 || item.estimatedCost.count == 0 {
            return false
        }
        return true
    }
}
