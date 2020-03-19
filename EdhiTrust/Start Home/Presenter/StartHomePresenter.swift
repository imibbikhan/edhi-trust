//
//  StartHomePresenter.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 19/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
class StartHomePresenter {
    var delegate: StartHomeDelegate?
    var bloodRequestPresenter = BloodRequestsPresenter()
    var missingPresenter = MissingPresenter()
    
    func setupDelegates() {
        bloodRequestPresenter.delegate = self
        missingPresenter.delegate = self
    }
    func getBloodAndMissings() {
        print("called...")
        bloodRequestPresenter.getBloodRequests(all: true, myCity: true)
        missingPresenter.getAllMissings(all: true, myCity: true)
    }
}
// MARK: - Missing Blood Request
extension StartHomePresenter: BloodRequestsDelegate & MissingDelegate {
    func requestsFetched(requests: [BloodRequestModel]) {
        print("fetched..")
        delegate?.bloodRequestsFetched(requests: requests)
    }
    
    func error(message: String) {
        delegate?.error(message: message)
    }
    
    func missingsFetched(missings: [MissingModel]) {
        print("fetched..2")
        delegate?.missingRequestsFetched(missings: missings)
    }
}
