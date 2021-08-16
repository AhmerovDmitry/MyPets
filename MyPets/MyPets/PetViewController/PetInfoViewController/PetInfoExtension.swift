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
        delegate?.deleteEntity(at: collectionItemIndex!)
        navigationController?.popToRootViewController(animated: true)
    }
    
    func savePetBirthday() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        petInfo = dateFormatter.string(from: self.picker.date)
//        petEntity.birthday = petInfo
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            petInfo = nil
        } else {
            petInfo = textField.text
        }
    }
    
    func popToRootController() {
        navigationController?.popToRootViewController(animated: true)
        
//        if !(petEntity == nilEntity) {
//            if collectionItemIndex == nil {
//                delegate?.createEntity(petEntity)
//            } else {
//                if !(petEntity == nilEntity) {
//                    delegate?.updateEntity(petEntity, at: collectionItemIndex!)
//                }
//            }
//        } else {
//            if collectionItemIndex != nil {
//                delegate?.deleteEntity(at: collectionItemIndex!)
//            }
//        }
        delegate?.reloadCollectionView()
        delegate?.reloadController()
    }
}

extension PetInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        titleImage.image = info[.editedImage] as? UIImage
//        petEntity.image = titleImage.image
        dismiss(animated: true, completion: nil)
    }
    
    func setupEditButtons() {
        [cameraButton, editedButton, deleteButton].forEach({
            $0.frame = popToRootButton.frame
            $0.frame.origin = CGPoint(x: rightBarButtonFrame.origin.x,
                                      y: rightBarButtonFrame.origin.y)
            $0.imageEdgeInsets = UIEdgeInsets(top: popToRootButton.frame.height / 6,
                                              left: popToRootButton.frame.height / 6,
                                              bottom: popToRootButton.frame.height / 6,
                                              right: popToRootButton.frame.height / 6)
            
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

//MARK: - Delegate methods
extension PetInfoViewController: PetViewControllerDelegate, UITextFieldDelegate {
    func getTableView(_ tableView: UITableView) {
        self.tableView = tableView
    }
    
    func getCellInfo(indexPath: IndexPath, updateInformation: @escaping (IndexPath) -> ()) {
        self.indexPath = indexPath
        self.updateInfo = updateInformation
    }
    
    
    func updatePetInfo(updateInformation: @escaping (IndexPath) -> ()) {
        updateInformation(indexPath)
    }
    
    func showDatePicker() {
        UIView.animate(withDuration: 0.5) {
            self.picker.isHidden = false
            self.picker.alpha = 1
            self.backgroundView.isHidden = false
            self.backgroundView.alpha = 0.5
            self.saveDateButton.isHidden = false
            self.saveDateButton.alpha = 1
        }
    }
    
    func showAlertController(title: String,
                             message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { textField in
//                switch self.indexPath.row {
//                case 0:
//                    textField.text = self.petEntity.name
//                case 1:
//                    textField.text = self.petEntity.kind
//                case 2:
//                    textField.text = self.petEntity.breed
//                case 4:
//                    textField.text = self.petEntity.weight
//                case 5:
//                    textField.text = self.petEntity.sterile
//                case 6:
//                    textField.text = self.petEntity.color
//                case 7:
//                    textField.text = self.petEntity.hair
//                case 8:
//                    textField.text = self.petEntity.chipNumber
//                default: break
//                }
                textField.textAlignment = .left
                textField.textColor = UIColor.CustomColor.dark
                textField.placeholder = "Введите информацию о питомце"
                textField.addTarget(self,
                                    action: #selector(self.textFieldDidEndEditing(_:)),
                                    for: .editingDidEnd)
            }
            let saveButton = UIAlertAction(title: "Сохранить", style: .default) { _ in
                self.updatePetInfo(updateInformation: self.updateInfo!)

//                switch self.indexPath.row {
//                case 0:
//                    self.petEntity.name = self.petInfo
//                case 1:
//                    self.petEntity.kind = self.petInfo
//                case 2:
//                    self.petEntity.breed = self.petInfo
//                case 4:
//                    self.petEntity.weight = self.petInfo
//                case 5:
//                    self.petEntity.sterile = self.petInfo
//                case 6:
//                    self.petEntity.color = self.petInfo
//                case 7:
//                    self.petEntity.hair = self.petInfo
//                case 8:
//                    self.petEntity.chipNumber = self.petInfo
//                default: break
//                }
                self.tableView.reloadData()
                self.petInfo = nil
            }
            let cancelButton = UIAlertAction(title: "Отменить", style: .cancel)
            alert.addAction(saveButton)
            alert.addAction(cancelButton)

            present(alert, animated: true, completion: nil)
        }
    
    func petInfoForModel() -> String? {
        return petInfo
    }
}
