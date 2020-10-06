//
//  CenterDetailPresenter.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 06/10/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
class CenterDetailPresenter {
    var delegate: CenterDetailDelegates?
    
    func getCentersDetails() {
        DBHandler.shared.getCentersDetails { (centers, error) in
            if let error = error {
                self.delegate?.error(message: error)
                return
            }
            let allCenters = centers.values.sorted { $0.centerName < $1.centerName }
            self.delegate?.centersFetched(centers: allCenters)
        }
    }
}
