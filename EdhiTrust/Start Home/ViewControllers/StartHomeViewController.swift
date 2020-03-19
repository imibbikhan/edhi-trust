//
//  StartHomeViewController.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 06/01/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import UIKit
import ImageSlideshow
import CoreLocation
import PKHUD
class StartHomeViewController: UIViewController {
    // MARK: - Interface Outlets
    @IBOutlet weak var slideShow: ImageSlideshow!
    @IBOutlet weak var missingCollectionView: UICollectionView!
    @IBOutlet weak var bloodCollectionView: UICollectionView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    // MARK: - Properties
    var list = ["Home", "Ambulance", "Blood", "Missings", "Donations", "Call Center", "Edit Profile", "Centers"]
    var locationManager = CLLocationManager()
    var presenter: StartHomePresenter!
    var missings: [MissingModel]!
    var bloodRequests: [BloodRequestModel]!
    
    // MARK: - ViewControllers life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        missings = [MissingModel]()
        bloodRequests = [BloodRequestModel]()
        setupUI()
    }
}
// MARK: - Private Methods
extension StartHomeViewController {
    fileprivate func setupUI() {
        setupDelegates()
        setupSlideShow()
        self.navigationController?.navigationBar.topItem?.title = "EDHI Welfare Trust"
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        setupLocationManager()
        
        presenter = StartHomePresenter()
        presenter.setupDelegates()
        presenter.delegate = self
        HUD.show(.progress)
    }
    fileprivate func setupDelegates() {
        missingCollectionView.delegate = self
        missingCollectionView.dataSource = self
        
        bloodCollectionView.delegate = self
        bloodCollectionView.dataSource = self
        
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
    }
    fileprivate func setupSlideShow() {
        slideShow.contentScaleMode = .scaleAspectFill
        var sdWebImageSource = [SDWebImageSource]()
        sdWebImageSource.append(SDWebImageSource(urlString: "https://i.pinimg.com/originals/38/dd/08/38dd088a7a4fc825209d03e0b4ca96f3.jpg")!)
        sdWebImageSource.append(SDWebImageSource(urlString: "https://uwpics.urduwire.com/images_photos/photos/edhi08884834_201678163240.jpg")!)
        sdWebImageSource.append(SDWebImageSource(urlString: "https://miro.medium.com/max/960/1*f2ozJFV2Xz1WBuRnwcCFRg.jpeg")!)
        
        slideShow.setImageInputs(sdWebImageSource)
    }
    fileprivate func menuCollectionClicked(index: Int) {
        let vc = STORYBOARD.instantiateViewController(withIdentifier: list[index])
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // Location Manager
    fileprivate func setupLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = 6
            locationManager.requestAlwaysAuthorization()
            self.checkStatus()
        }else{
            PopUp.shared.show(view: self, message: "Location services are off. On your services, you will be able see near ambulances, missings and blood requests.")
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
}
// MARK: - CollectionView Delegates
extension StartHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == menuCollectionView {
            self.menuCollectionClicked(index: indexPath.row)
            return
        }
        if collectionView == bloodCollectionView {
            Navigator.toViewBloodRequest(request: self.bloodRequests[indexPath.row], from: self)
            return
        }
        Navigator.toViewMissingRequest(missing: self.missings[indexPath.row], from: self)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.size.width/4
        if collectionView == menuCollectionView {
            print("collectionViewIn")
            return CGSize(width: width - 10, height: 95)
        }
        
        return CGSize(width: 70, height: 70)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == menuCollectionView {
            return list.count
        }
        if collectionView == bloodCollectionView {
            return bloodRequests.count
        }
        return missings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == bloodCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BloodCell", for: indexPath) as? NearBloodDonations
            cell?.titleText.text = self.bloodRequests[indexPath.row].bloodGroup
            return cell!
        }
        if collectionView == missingCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MissingCell", for: indexPath) as? NearMissingCell
            cell?.missingImage.sd_setImage(with: URL(string: self.missings[indexPath.row].imageURL))
            return cell!
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as? ItemCell
        cell?.titleText.text = list[indexPath.row]
        cell?.iconView.image = UIImage(named: list[indexPath.row])
        return cell!
        
    }
}
// MARK: - LocationManager Delegates
extension StartHomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            Locations.getGeoAddress(location: location) { (location) in
                DEFAULTS.set(location, forKey: "CurrentCity")
                print(location)
            }
        }
        manager.stopUpdatingLocation()
        presenter.getBloodAndMissings()
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
}
// MARK: - Start Home Delegate
extension StartHomeViewController: StartHomeDelegate {
    func bloodRequestsFetched(requests: [BloodRequestModel]) {
        DispatchQueue.main.async {
            HUD.flash(.progress, delay: 3)
            self.bloodRequests = requests
            self.bloodCollectionView.reloadData()
        }
    }
    
    func missingRequestsFetched(missings: [MissingModel]) {
        DispatchQueue.main.async {
            HUD.flash(.progress, delay: 3)
            self.missings = missings
            self.missingCollectionView.reloadData()
        }
    }
    
    func error(message: String) {
        DispatchQueue.main.async {
            HUD.hide()
            PopUp.shared.show(view: self, message: message)
        }
    }
    
    
}
// MARK: - CollectionViewCell
class ItemCell: UICollectionViewCell {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleText: UILabel!
}
class NearMissingCell: UICollectionViewCell {
    @IBOutlet weak var missingImage: UIImageView!
    
    override func awakeFromNib() {
        missingImage.layer.cornerRadius = missingImage.frame.size.width/2
        missingImage.clipsToBounds = true
    }
}
class NearBloodDonations: UICollectionViewCell {
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var roundedView: UIView!
    
    override func awakeFromNib() {
        roundedView.layer.cornerRadius = 35
        roundedView.backgroundColor = BLOOD_COLOR
    }
}
