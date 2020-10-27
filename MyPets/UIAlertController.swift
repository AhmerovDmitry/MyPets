//
//  UIAlertController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 25.10.2020.
//

import UIKit

extension UIAlertController {
    //MARK: - Settings for UIAlertController
    func showAlert(title: String, message: String?, urlForSystemWay url: String?) {
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
}
