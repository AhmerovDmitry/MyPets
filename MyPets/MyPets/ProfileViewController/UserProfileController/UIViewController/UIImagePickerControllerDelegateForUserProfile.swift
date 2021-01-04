//
//  UIImagePickerControllerDelegateForUserProfile.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 04.01.2021.
//

import UIKit

extension UserProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profileView.setBackgroundImage(info[.editedImage] as? UIImage, for: .normal)
        
        dismiss(animated: true, completion: nil)
    }
}
