//
//  AmbulancesViewController.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 06/01/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import UIKit
import GoogleMaps
import PullUpController
class AmbulancesViewController: UIViewController {
    // MARK: - Interface Outlets
    @IBOutlet weak var mapView: GMSMapView!
    
    // MARK: - Properties
    var locationManager = CLLocationManager()
    
    // MARK: - ViewControllers life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLocationManager()
    }
    override func viewWillAppear(_ animated: Bool) {
        guard let tab = self.tabBarController else { return }
        tab.tabBar.tintColor = EDHI_PRIMARY
        tab.navigationItem.title = "Ambluances"
    }

    // MARK: - Objc Methods
    @objc func showAll() {
        let vc = STORYBOARD.instantiateViewController(withIdentifier: "AllAmbulances")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
// MARK: - Private Methods
extension AmbulancesViewController {
    fileprivate func setupUI() {
        self.navigationItem.title = "Ambulances"
        styleMap()
        
        let btn = UIBarButtonItem(title: "All", style: .done, target: self, action: #selector(showAll))
        self.navigationItem.rightBarButtonItem = btn
    }
    fileprivate func setupLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = 2
            locationManager.requestAlwaysAuthorization()
            self.checkStatus()
        }else{
            PopUp.shared.show(view: self, message: "Location services are off.")
        }
    }
    fileprivate func checkStatus() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined, .restricted, .denied:
            print("deineied")
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    fileprivate func addMarkers(coordinates: CLLocationCoordinate2D) {
        DispatchQueue.main.async {
            self.mapView.clear()
            let marker = GMSMarker(position: coordinates)
            marker.icon = GMSMarker.markerImage(with: UIColor(hexString: PRIMARY_COLOR))
            marker.map = self.mapView
        }
    }
    fileprivate func styleMap() {
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
    }
}
// MARK: - LocationManager Delegates
extension AmbulancesViewController: CLLocationManagerDelegate, GMSMapViewDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                                  longitude: location.coordinate.longitude,
                                                  zoom: 15.0)
            mapView.camera = camera
            mapView.delegate = self
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
            self.addMarkers(coordinates: location.coordinate)
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("User still thinking granting location access!")
            locationManager.startUpdatingLocation() // this will access location automatically if user granted access manually. and will not show apple's request alert twice. (Tested)
            
            break
            
        case .denied:
            print("User denied location access request!!")
            // show text on label
            print("To re-enable, please go to Settings and turn on Location Service for this app.")
            view.reloadInputViews()
            locationManager.stopUpdatingLocation()
            break
            
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation() //Will update location immediately
            break
            
        case .authorizedAlways:
            locationManager.startUpdatingLocation() //Will update location immediately
            break
        default:
            break
        }
    }
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let amb = STORYBOARD.instantiateViewController(withIdentifier: "AmbulanceView")
//        amb.modalPresentationStyle = .fullScreen
        self.present(amb, animated: true)
        return true
    }
}
