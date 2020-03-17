//
//  PostMissingViewController.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 12/01/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import UIKit
import PKHUD
class PostMissingViewController: UIViewController {
    // MARK: - Interface Outlets
    @IBOutlet weak var missingImageView: UIImageView!
    @IBOutlet weak var missingName: IconTextFieldView!
    @IBOutlet weak var missingAge: IconTextFieldView!
    @IBOutlet weak var fromLocation: IconTextFieldView!
    @IBOutlet weak var dissappearedLocation: IconTextFieldView!
    @IBOutlet weak var missingDate: IconTextFieldView!
    @IBOutlet weak var missingType: UIButton!
    @IBOutlet weak var fullAddress: IconTextFieldView!
    @IBOutlet weak var gender: UIButton!
    @IBOutlet weak var postMissingBtn: UIButton!
    
    // MARK: - Properties
    var presenter: PostMissingPresenter!
    var missingModel: MissingModel!
    
    // MARK: - ViewControllers life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        presenter = PostMissingPresenter()
        presenter.delegate = self
    }
}
// MARK: - Private Methods
extension PostMissingViewController {
    fileprivate func setupUI() {
        
        self.navigationItem.title = "Post Missing"
        fromLocation.icon.image = UIImage(named: "pin2")
        dissappearedLocation.icon.image = UIImage(named: "pin2")
        missingAge.icon.image = UIImage(named: "age")
        missingDate.icon.image = UIImage(named: "date")
        fullAddress.icon.image = UIImage(named: "address")
        missingType.narrowShadow()
        gender.narrowShadow()
        postMissingBtn.stylePrimaryBtn()
        missingImageView.circular()
        missingDate.field.delegate = self
        
    }
    fileprivate func createMissingModel(url: String)->MissingModel {
        var key = DBHandler.shared.getAutoId()
        
        if let model = missingModel {
            key = model.missingKey
        }
        let name = missingName.field.text ?? ""
        let age = missingAge.field.text ?? ""
        let from = fromLocation.field.text ?? ""
        let dissappearedFrom = dissappearedLocation.field.text ?? ""
        
        let missingDateStr = missingDate.field.text ?? ""
        let missingTypeText = missingType.titleLabel?.text ?? ""
        let genderText = gender.titleLabel?.text ?? ""
        let address = fullAddress.field.text ?? ""
        let number = User.getPhoneNumber()
        let uid = User.getUid()
        
        let missing = MissingModel(missingKey: key, missingName: name, city: from, address: address, gender: genderText, phoneNumber: number, age: age, imageURL: url, missingStatus: missingTypeText, userKey: uid, disappearedDate: missingDateStr, dissappearedCity: dissappearedFrom)
        return missing
    }
    // MARK: - Interface Actions
    @IBAction func pickImageClicked(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true)
    }
    @IBAction func genderClicked(_ sender: UIButton) {
        StringPicker.showPicker(title: "Select Gender", choices: ["Male", "Female", "Other"], base: self, origin: sender)
        StringPicker.doneClicked = { title in
            self.gender.setTitle(title, for: .normal)
        }
    }
    @IBAction func missingTypeClicked(_ sender: UIButton) {
        StringPicker.showPicker(title: "Select Type", choices: ["Lost", "Found"], base: self, origin: sender)
        StringPicker.doneClicked = { title in
            self.missingType.setTitle(title, for: .normal)
        }
    }
    @IBAction func postMissingClicked(_ sender: UIButton) {
        HUD.show(.progress)
        presenter.uploadMissingImage(image: missingImageView.image!, missing: createMissingModel(url: ""))
    }
}
// MARK: - Image Picker delegate
extension PostMissingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[.originalImage] as? UIImage {
            self.missingImageView.image = img
        }
        self.dismiss(animated: true, completion: nil)
    }
}
// MARK: - PostMissing Delegate
extension PostMissingViewController: PostMissingDelegate {
    func postSuccess() {
        DispatchQueue.main.async {
            HUD.hide()
            self.navigationController?.popViewController(animated: true)
        }
    }
    // now saving missing data.
    func imageUploaded(url: String) {
        presenter.postMissing(missing: createMissingModel(url: url))
    }
    
    func error(message: String) {
        HUD.hide()
        PopUp.shared.show(view: self, message: message)
    }
    
    
}
// MARK: - textfield delegate
extension PostMissingViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == missingDate.field {
            DatePicker.datePicker(view: missingDate, base: self) { (date) in
                self.missingDate.field.text = date
            }
        }
        return false
    }
}
