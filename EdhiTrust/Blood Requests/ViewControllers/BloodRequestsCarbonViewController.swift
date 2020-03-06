//
//  BloodRequestsCarbonViewController.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 06/01/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import UIKit
import CarbonKit
class BloodRequestsCarbonViewController: UIViewController {
    // MARK: - Interface Outlets
    @IBOutlet weak var tabView: UIView!
    
    // MARK: - ViewControllers life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}
// MARK: - Private Methods
extension BloodRequestsCarbonViewController {
    fileprivate func setupUI() {
        self.navigationItem.title = "Blood Donation"
        setupCarbonKit()
    }
    fileprivate func setupCarbonKit() {
        let items = ["REQUESTS", "MY REQUESTS", "POST"]
        let carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items, delegate: self)
        let width = self.view.frame.width/3
        carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(width, forSegmentAt: 0)
        carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(width, forSegmentAt: 1)
        carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(width, forSegmentAt: 2)
        
        carbonTabSwipeNavigation.setupCarbon(view: tabView, target: self)
    }
}
// MARK: - Carbon Kit Delegates
extension BloodRequestsCarbonViewController: CarbonTabSwipeNavigationDelegate {
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        var identifier = ""
        switch index {
        case 0:
            identifier = "BloodRequests"
        case 1:
            identifier = "BloodRequests"
        default:
            identifier = "PostBloodRequest"
        }
        
        let viewController = STORYBOARD.instantiateViewController(withIdentifier: identifier)
        return viewController
    }
}
