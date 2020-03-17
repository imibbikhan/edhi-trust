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
    
    func getAllMissings(all: Bool) {
        guard let delegate = self.delegate else { return }
        DBHandler.shared.getMissingRequests(all: all) { (missings, error) in
            if let err = error {
                delegate.error(message: err)
                return
            }
            delegate.missingsFetched(missings: missings)
        }
    }
}
