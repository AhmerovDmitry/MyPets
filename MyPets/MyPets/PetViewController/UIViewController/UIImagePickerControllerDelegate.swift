//
//  UIImagePickerControllerDelegate.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 02.12.2020.
//

import UIKit

extension PetInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        titleImage.image = info[.editedImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
}
