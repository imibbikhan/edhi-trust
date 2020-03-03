//
//  StartHomeViewController.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 06/01/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import UIKit
import ImageSlideshow
class StartHomeViewController: UIViewController {
    // MARK: - Interface Outlets
    @IBOutlet weak var slideShow: ImageSlideshow!
    @IBOutlet weak var missingCollectionView: UICollectionView!
    @IBOutlet weak var bloodCollectionView: UICollectionView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    // MARK: - Properties
    var list = ["Home", "Ambulance", "Blood", "Missings", "Donations", "Call Center", "Edit Profile", "Centers"]
    // MARK: - ViewControllers life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
// MARK: - CollectionView Delegates
extension StartHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == menuCollectionView {
            self.menuCollectionClicked(index: indexPath.row)
        }
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == bloodCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BloodCell", for: indexPath) as? NearBloodDonations
            return cell!
        }
        if collectionView == missingCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MissingCell", for: indexPath) as? NearMissingCell
            return cell!
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as? ItemCell
        cell?.titleText.text = list[indexPath.row]
        cell?.iconView.image = UIImage(named: list[indexPath.row])
        return cell!
        
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
