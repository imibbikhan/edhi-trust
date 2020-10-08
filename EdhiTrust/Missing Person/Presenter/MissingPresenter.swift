//
//  MissingPresenter.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 17/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
class MissingPresenter {
    var delegate: MissingDelegate?
    
    func getAllMissings(all: Bool, myCity: Bool = false) {
        guard let delegate = self.delegate else { return }
        DBHandler.shared.getMissingRequests(all: all, myCity: myCity) { (missings, error) in
            if let err = error {
                delegate.error(message: err)
                return
            }
            if all {
                print(missings)
            }
            delegate.missingsFetched(missings: missings)
        }
    }
    func deleteMissingPost(key: String) {
        DBHandler.shared.deleteMissing(key: key)
    }
}
