//
//  StartHomeViewController.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 06/01/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import UIKit

class StartHomeViewController: UIViewController {
    // MARK: - Interface Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    var list = ["Home", "Ambulance", "Blood Requests", "Missing Person", "Contact Center", "Center Details", "Donations", "Edit Profile"]
    // MARK: - ViewControllers life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
// MARK: - Private Methods
extension StartHomeViewController {
    fileprivate func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.navigationController?.navigationBar.topItem?.title = "EDHI"
        self.navigationController?.navigationBar.barTintColor = EDHI_PRIMARY
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
}
// MARK: - CollectionView Delegates
extension StartHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = STORYBOARD.instantiateViewController(withIdentifier: list[indexPath.row])
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.size.width/2)-20
        return CGSize(width: width, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as? ItemCell
        item?.titleText.text = list[indexPath.row]
        item?.iconView.image = UIImage(named: list[indexPath.row].lowercased())
        return item!
    }
}
// MARK: - CollectionViewCell
class ItemCell: UICollectionViewCell {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleText: UILabel!
}
