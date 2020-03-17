//
//  MissingDelegate.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 15/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
protocol PostMissingDelegate {
    func postSuccess()
    func imageUploaded(url: String)
    func error(message: String)
}
protocol MissingDelegate {
    func missingsFetched(missings: [MissingModel])
    func error(message: String)
}
