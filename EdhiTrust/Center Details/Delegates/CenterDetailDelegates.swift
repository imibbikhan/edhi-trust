//
//  CenterDetailDelegates.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 06/10/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
protocol CenterDetailDelegates {
    func centersFetched(centers: [CenterModel])
    func error(message: String)
}
