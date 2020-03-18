//
//  DBHandler.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 06/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
import Firebase
import CodableFirebase
import CoreLocation
class DBHandler {
    static var shared = DBHandler()
    
    func getAutoId()->String{
        return FB_DB_REF.childByAutoId().key ?? UUID().uuidString
    }
    func postNow(path: String, data: Any, success: @escaping (String?)->Void) {
        FB_DB_REF.child(path).setValue(data) {
            (error, refer) in
            if let error = error {
                success(error.localizedDescription)
            }else{
                success(nil)
            }
        }
    }
    func getBloodRequestsDB(allRequests: Bool, fetched: @escaping ([BloodRequestModel], String?)->Void) {
        var query = FB_DB_REF.child("blood_requests").queryOrdered(byChild: "user_key").queryEqual(toValue: User.getUid())
        
        if !allRequests {
            query = FB_DB_REF.child("blood_requests")
        }
        
        var requests = [BloodRequestModel]()
        query.observe(.value, with: { (snapShot) in
            requests.removeAll()
            for case let request as DataSnapshot in snapShot.children {
                do {
                    let decodedRequest = try FirebaseDecoder().decode(BloodRequestModel.self, from: request.value!)
                    print(decodedRequest)
                    requests.append(decodedRequest)
                }catch{
                    fetched(requests, error.localizedDescription)
                }
            }
            
            fetched(requests, nil)
            
        }) { (error) in
            fetched(requests, error.localizedDescription)
        }
        
    }
    func getMissingRequests(all: Bool, fetched: @escaping ([MissingModel], String?)->Void) {
        var query = FB_DB_REF.child("missing_requests").queryOrdered(byChild: "user_key").queryEqual(toValue: User.getUid())
        
        if !all {
            query = FB_DB_REF.child("missing_requests")
        }
        
        var requests = [MissingModel]()
        query.observe(.value, with: { (snapShot) in
            requests.removeAll()
            for case let request as DataSnapshot in snapShot.children {
                do {
                    let decodedRequest = try FirebaseDecoder().decode(MissingModel.self, from: request.value!)
                    requests.append(decodedRequest)
                }catch{
                    fetched(requests, error.localizedDescription)
                }
            }
            
            fetched(requests, nil)
            
        }) { (error) in
            fetched(requests, error.localizedDescription)
        }
        
    }
    func getAmbulances(city: String, myLocation: CLLocation ,fetched: @escaping ([AmbulanceModel], String?)->Void) {
        let query = FB_DB_REF.child("ambulances").queryOrdered(byChild: "city").queryEqual(toValue: city)
        var ambulances = [AmbulanceModel]()
        query.observe(.value, with: { (snapShot) in
            ambulances.removeAll()
            for case let request as DataSnapshot in snapShot.children {
                do {
                    var amb = try FirebaseDecoder().decode(AmbulanceModel.self, from: request.value!)
                    let distance = Locations.getDistance(destination: CLLocationCoordinate2D(latitude: amb.location.lati, longitude: amb.location.longi), myLocation: myLocation)
                    amb.onDistance = distance
                    ambulances.append(amb)
                }catch{
                    fetched(ambulances, error.localizedDescription)
                }
            }
            
            fetched(ambulances, nil)
            
        }) { (error) in
            fetched(ambulances, error.localizedDescription)
        }
        
    }
    func editProfile(data: Any, success: @escaping (String?)->Void) {
        let uid = User.getUid()
        FB_DB_REF.child("users/\(uid)").setValue(data) {
            (error, refer) in
            if let err = error {
                success(err.localizedDescription)
            }else{
                success(nil)
            }
        }
    }
}

