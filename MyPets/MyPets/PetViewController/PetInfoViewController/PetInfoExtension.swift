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
    
    func editPetInfo() {}
    
    func deletePet() {
        MainPetViewController.shared.tappedDeleteButton = true
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
    
    func popToRootController() {
        navigationController?.popToRootViewController(animated: true)
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
        [cameraButton, editedButton, deleteButton].forEach({
            $0.frame.size = CGSize(width: rightBarButtonFrame.size.width,
                                   height: rightBarButtonFrame.size.width)
            $0.frame.origin = CGPoint(x: rightBarButtonFrame.origin.x,
                                      y: rightBarButtonFrame.origin.y)
            $0.imageEdgeInsets = UIEdgeInsets(top: rightBarButtonFrame.size.width / 6,
                                              left: rightBarButtonFrame.size.width / 6,
                                              bottom: rightBarButtonFrame.size.width / 6,
                                              right: rightBarButtonFrame.size.width / 6)
            
            $0.backgroundColor = UIColor.CustomColor.lightGray
            $0.tintColor = UIColor.CustomColor.dark
            $0.alpha = 0
            $0.imageView?.contentMode = .scaleAspectFit
            $0.layer.cornerRadius = $0.frame.height / 2
            
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
