//
//  UIAlertController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 25.10.2020.
//

import UIKit

extension UIAlertController {
    func showAlertForMap(title: String, message: String?, urlForSystemWay url: String?) {
        guard let url = url else { return }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Настройки", style: .default) { _ in
            if let url = URL(string: url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(settingsAction)
        present(alert, animated: true, completion: nil)
    }
    func showGlobalWarning(title: String, message: String, buttonText: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let button = UIAlertAction(title: buttonText, style: .cancel, handler: nil)
        alert.addAction(button)
        present(alert, animated: true, completion: nil)
    }
}
