//
//  UIAlertController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 25.10.2020.
//

import UIKit

extension UIAlertController {
    //MARK: - Settings for UIAlertController
    func showAlertForMap(title: String, message: String?, urlForSystemWay url: String?) {
        guard let url = url else { return }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Настройки", style: .default) { (alert) in
            if let url = URL(string: url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(settingsAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func showAlertForMainView(title: String, infoFor label: UILabel, in controller: UIViewController) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        var text: String?
        alert.addTextField { (textField) in
            textField.textAlignment = .left
            textField.textColor = UIColor.CustomColor.dark
            textField.placeholder = "Введите информацию о питомце"
            text = textField.text
        }
        let saveButton = UIAlertAction(title: "Сохранить", style: .default) { (action) in
            label.text = text
        }
        let cancelButton = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        
        alert.addAction(saveButton)
        alert.addAction(cancelButton)
        
        controller.present(alert, animated: true, completion: nil)
    }
}
