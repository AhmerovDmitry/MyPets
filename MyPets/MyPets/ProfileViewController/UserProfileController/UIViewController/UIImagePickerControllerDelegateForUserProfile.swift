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
        
        let userPhoto = info[.editedImage] as? UIImage
        profileView.setBackgroundImage(userPhoto, for: .normal)
        delegate?.updateUser(image: userPhoto)
        
        dismiss(animated: true, completion: nil)
    }
}
