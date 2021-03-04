//
//  @objc PetInfoViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 28.11.2020.
//

import UIKit

@objc
extension PetInfoViewController {
    func presentController() {
        let photoGallery = UIImagePickerController()
        photoGallery.allowsEditing = true
        photoGallery.sourceType = .photoLibrary
        photoGallery.delegate = self
        
        present(photoGallery, animated: true, completion: nil)
    }
    
    func savePetBirthday() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        petInfo = dateFormatter.string(from: self.picker.date)
        petEntity.birthday = petInfo
        updatePetInfo(updateInformation: updateInfo!)
        tableView.reloadData()
        hideDatePicker(nil)
    }
    
    func hideDatePicker(_ sender: UITapGestureRecognizer?) {
        UIView.animate(withDuration: 0.5) {
            self.picker.alpha = 0
            self.backgroundView.alpha = 0
            self.saveDateButton.alpha = 0
        } completion: { _ in
            self.picker.isHidden = true
            self.backgroundView.isHidden = true
            self.saveDateButton.isHidden = true
            self.petInfo = nil
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        petInfo = textField.text
    }
}
