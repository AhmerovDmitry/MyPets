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
        showEditedButtons = !showEditedButtons
    }
    
    func editPetInfo() {
        tappedEditedButton = !tappedEditedButton
    }
    
    func deletePet() {
        print("Delete")
        navigationController?.popToRootViewController(animated: true)
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
        [cameraButton, editedButton, deleteButton].forEach({
            $0.frame.size = rightBarButtonFrame.size
            $0.frame.origin = CGPoint(x: rightBarButtonFrame.origin.x,
                                      y: rightBarButtonFrame.origin.y)
            view.addSubview($0)
        })
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
