//
//  CallCenterPresenter.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 06/10/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
class CallCenterPresenter {
    var delegate: CallCenterDelegates?
    
    func getCenters() {
        DBHandler.shared.getCallCenters { (centers, error) in
            if let error = error {
                self.delegate?.error(message: error)
                return
            }
            let allCenters = centers.values.sorted { $0.name < $1.name }
            self.delegate?.centersFetched(centers: allCenters)
        }
    }
}
