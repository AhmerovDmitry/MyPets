//
//  UIViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 13.01.2021.
//

import UIKit

extension UIViewController {

    /// Метод показывает контроллер с возможностью купить премиум версию приложения
    /// - Parameter target: Контроллер по верх которого показывается PremiumController
//    func presentPremiumController(_ target: UIViewController?) {
//        let premiumVC = PremiumController(userDefaultsService: )
//        premiumVC.modalPresentationStyle = .fullScreen
//        target?.present(premiumVC, animated: true, completion: nil)
//    }

    /*
    /// Метод открывающий (push) следующий контроллер без заголовка в кнопке возврата
    /// Удалить из-за ненадобности
    func openControllerWithoutBackBarItemTitle(_ controller: UIViewController) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor.CustomColor.dark
        navigationController?.pushViewController(controller, animated: true)
    }
    func pushView(controller: UIViewController, withTitle: String) {
        controller.navigationController?.navigationBar.tintColor = UIColor.CustomColor.dark
        controller.navigationController?.navigationBar.prefersLargeTitles = true
        controller.navigationController?.navigationBar.backgroundColor = .clear
        controller.navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.CustomColor.dark
        ]
        controller.navigationItem.title = withTitle
        self.navigationController?.pushViewController(controller, animated: true)
    }
    */
}
