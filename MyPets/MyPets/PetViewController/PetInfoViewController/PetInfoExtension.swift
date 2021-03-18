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
    
    func showEditButtons() {
        setupEditButtons()
        UIView.animate(withDuration: 0.5, animations: {
//            self.view.layoutIfNeeded()
            self.cameraButton.alpha = 1
            self.editedButton.alpha = 1
            self.cameraButton.frame.size = self.rightBarButtonFrame.size
            self.cameraButton.frame.origin = CGPoint(x: self.rightBarButtonFrame.origin.x,
                                                     y: self.rightBarButtonFrame.origin.y + self.rightBarButtonFrame.origin.y)

            self.editedButton.frame.size = self.rightBarButtonFrame.size
            self.editedButton.frame.origin = CGPoint(x: self.rightBarButtonFrame.origin.x,
                                                     y: self.rightBarButtonFrame.origin.y + self.rightBarButtonFrame.origin.y * 2)
        }, completion: nil)
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

extension PetInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        titleImage.image = info[.editedImage] as? UIImage
        petEntity.image = titleImage.image
        dismiss(animated: true, completion: nil)
    }
    
    func setupEditButtons() {
        rightBarButtonFrame = fetchRightBarButtonFrame()
        cameraButton.frame.size = rightBarButtonFrame.size
        cameraButton.frame.origin = CGPoint(x: rightBarButtonFrame.origin.x,
                                            y: rightBarButtonFrame.origin.y)
        
        editedButton.frame.size = rightBarButtonFrame.size
        editedButton.frame.origin = CGPoint(x: rightBarButtonFrame.origin.x,
                                            y: rightBarButtonFrame.origin.y)
        
        view.addSubview(cameraButton)
        view.addSubview(editedButton)
    }
    
    func fetchRightBarButtonFrame() -> CGRect {
        var frame = CGRect()
        if let barView = navigationItem.rightBarButtonItem?.value(forKey: "view") as? UIView {
            let barFrame = barView.frame
            let rect = barView.convert(barFrame, to: view)

            frame = rect
        }
        
        return frame
    }
}
