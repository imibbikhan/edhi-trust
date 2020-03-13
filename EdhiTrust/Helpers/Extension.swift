//
//  Extension.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 06/01/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
import UIKit
import CarbonKit

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(Float(r) / 255), green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
extension UIButton {
    func roundBtn(corners: CGFloat) {
        self.layer.cornerRadius = corners
    }
}
extension UISegmentedControl{
    func removeBorder(){
        let backgroundImage = UIImage.getColoredRectImageWith(color: UIColor(hexString: PRIMARY_COLOR).cgColor, andSize: self.bounds.size)
        self.setBackgroundImage(backgroundImage, for: .normal, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .selected, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .highlighted, barMetrics: .default)
        
        let deviderImage = UIImage()
        self.setDividerImage(deviderImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
    }
    
    func addUnderlineForSelectedSegment(){
        removeBorder()
        let underlineWidth: CGFloat = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let underlineHeight: CGFloat = 4.0
        let underlineXPosition = CGFloat(selectedSegmentIndex * Int(underlineWidth))
        let underLineYPosition = self.bounds.size.height - 1.0
        let underlineFrame = CGRect(x: underlineXPosition, y: underLineYPosition, width: underlineWidth, height: underlineHeight)
        let underline = UIView(frame: underlineFrame)
        underline.backgroundColor = UIColor.white
        underline.tag = 1
        self.addSubview(underline)
    }
    
    func changeUnderlinePosition(){
        guard let underline = self.viewWithTag(1) else {return}
        let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)
        UIView.animate(withDuration: 0.1, animations: {
            underline.frame.origin.x = underlineFinalXPosition
        })
    }
    func changeFont(fontSize: CGFloat) {
        let font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        self.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
    }
}

extension UIImage{
    class func getColoredRectImageWith(color: CGColor, andSize size: CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let graphicsContext = UIGraphicsGetCurrentContext()
        graphicsContext?.setFillColor(color)
        let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        graphicsContext?.fill(rectangle)
        let rectangleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rectangleImage!
    }
}
extension UITextView {
    func addRoundedBorder() {
        let borderColor = UIColor(hexString: LIGHT_GREY_COLOR)
        self.layer.borderWidth = 1.0
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = 5.0
    }
}
extension String {
    func letters()->Int {
        let removeWhiteSpace = self.replacingOccurrences(of: " ", with: "")
        return removeWhiteSpace.count
    }
}
extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}

extension UIViewController {
    public func addActionSheetForiPad(actionSheet: UIAlertController) {
        if let popoverPresentationController = actionSheet.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = []
        }
    }
}
class SheetConstraint{
    static func add(alert: UIAlertController){
        alert.view.subviews.flatMap({$0.constraints}).filter{ (one: NSLayoutConstraint)-> (Bool)  in
            return (one.constant < 0) && (one.secondItem == nil) &&  (one.firstAttribute == .width)
        }.first?.isActive = false
    }
}
extension UIButton {
    func stylePrimaryBtn() {
        self.addShadow()
        self.backgroundColor = UIColor.black
        self.layer.cornerRadius = 8
    }
    func styleSecondaryBtn() {
        self.backgroundColor = UIColor(hexString: LIGHT_GREY_COLOR)
        self.roundBtn(corners: 5)
    }
    func corners(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    func addShadow() {
        self.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 3
        self.layer.masksToBounds = false
    }
    func borders() {
        self.layer.borderWidth = 0.3
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    func narrowShadow() {
        self.layer.cornerRadius = 5.0
        self.layer.borderColor = UIColor(hexString: LIGHT_GREY_COLOR).cgColor
        self.layer.borderWidth = 1.0
    }
}
extension UIView {
    func roundCorner(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.backgroundColor = UIColor.white
        self.clipsToBounds = true
    }
    func reserveBgColor() {
        self.backgroundColor = UIColor(hexString: BACKGROUND_GREY_COLOR)
    }
}
extension Double {
    var makeReview:String {
        return String(format: "%.1f", self)
    }
}
extension CarbonTabSwipeNavigation {
    func setupCarbon(view: UIView, target: UIViewController) {
        self.setTabBarHeight(50)
        self.setIndicatorColor(UIColor(hexString: PRIMARY_COLOR))
        self.setNormalColor(UIColor.black, font: UIFont.boldSystemFont(ofSize: 16))
        self.setSelectedColor(UIColor.darkGray, font: UIFont.boldSystemFont(ofSize: 16))
        self.insert(intoRootViewController: target, andTargetView: view)
        self.toolbar.isTranslucent = false
        self.view.backgroundColor = UIColor.white
    }
}
extension UIImageView {
    func corners(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
   
    func circular() {
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
    

}
extension UIViewController {
    
    var hasSafeArea: Bool {
        guard
            #available(iOS 11.0, tvOS 11.0, *)
            else {
                return false
        }
        return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
    }
    
}
extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
