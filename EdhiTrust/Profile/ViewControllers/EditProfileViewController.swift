//
//  EditProfileViewController.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 13/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import UIKit
import PKHUD
class EditProfileViewController: UIViewController {

    // MARK: - Interface Outlets
    @IBOutlet weak var emailView: IconTextFieldView!
    @IBOutlet weak var displayNameView: IconTextFieldView!
    @IBOutlet weak var centerView: RoundShadowView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    
    // MARK: - Properties
    var presenter: EditProfilePresenter!
    
    // MARK: - ViewControllers life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        presenter = EditProfilePresenter()
        presenter.delegate = self
    }
    // MARK: - Interface Actions
    @IBAction func saveProfileClicked(_ sender: UIButton) {
        let name = displayNameView.field.text ?? ""
        let email = emailView.field.text ?? ""
        let image = profileImage.image ?? UIImage()
        HUD.show(.progress)
        presenter.editProfile(profile: ProfileModel.EditProfile(photo: image, email: email, displayName: name))
    }
    @IBAction func pickImageClicked(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true)
    }
}
// MARK: - Private Methods
extension EditProfileViewController {
    fileprivate func setupUI() {
        emailView.icon.image = UIImage(named: "pin2")
        emailView.field.placeholder = "Email"
        displayNameView.icon.image = UIImage(named: "person2")
        displayNameView.field.placeholder = "Display Name"
        saveBtn.backgroundColor = EDHI_PRIMARY
        profileImage.circular()
        
        self.saveBtn.stylePrimaryBtn()
    }
}
// MARK: - Image Picker delegate
extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[.originalImage] as? UIImage {
            self.profileImage.image = img
        }
        self.dismiss(animated: true, completion: nil)
    }
}
// MARK: - Edit Profile Delegates
extension EditProfileViewController: EditProfileDelegate {
    func success() {
        HUD.hide()
        Navigator.setRoot(window: self.view.window ?? UIWindow(), route: .home)
    }
    
    func error(message: String) {
        HUD.hide()
        PopUp.shared.show(view: self, message: message)
    }
    
    
}
