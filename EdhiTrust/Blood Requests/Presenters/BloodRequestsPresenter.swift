//
//  BloodRequestsPresenter.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 06/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
class BloodRequestsPresenter {
    var delegate: BloodRequestsDelegate?
    
    func getBloodRequests(all: Bool, myCity: Bool = false) {
        guard let delegate = self.delegate else { return }
        DBHandler.shared.getBloodRequestsDB(allRequests: all, myCity: myCity) { (requests, error) in
            if let err = error {
                delegate.error(message: err)
                return
            }
            delegate.requestsFetched(requests: requests)
        }
    }
}
