//
//  UIAlertController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 25.10.2020.
//

import UIKit

extension UIAlertController {
    /// Алерт для отображения проблем с геолокацией
    /// - Parameters:
    ///   - target: Контроллер на котором показывается алерт
    ///   - title: Заголовок алерт контроллера
    ///   - message: Сообщение алерт контроллера
    ///   - systemWayUrl: Путь к системным настройкам для удобства включения каких-то функций
    static func locationRequest(_ target: UIViewController, title: String, message: String?, systemWayUrl: String?) {
        guard let url = systemWayUrl else { return }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Настройки", style: .default) { _ in
            if let url = URL(string: url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(settingsAction)
        target.present(alert, animated: true, completion: nil)
    }
    /// Алерт для отображения сетевой ошибки
    /// - Parameters:
    ///   - target: Контроллер на котором показывается алерт
    ///   - error: Ошибка сетевого запроса
    ///   - completion: Комплишн хендлер если нужно что-то сделать после закрытия алерта
    static func presentAlertWithRequestError(_ target: UIViewController, error: Error?, completion: (() -> Void)?) {
        let alert = UIAlertController(title: "Упс, что-то пошло не по плану!",
                                      message: error?.localizedDescription,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Продолжить", style: .cancel, handler: nil))
        target.present(alert, animated: true, completion: completion)
    }
    /// Базовый алерт контроллер отображающий заголовок и сообщение
    /// Служит для базового предупреждения/оповещения пользователя
    /// - Parameters:
    ///   - target: Контроллер на котором показывается алерт
    ///   - title: Заголовок
    ///   - message: Сообщение в теле алерта
    ///   - style: Стиль алерт контроллера
    static func presentAlertWithBasicType(_ target: UIViewController,
                                          title: String?, message: String?,
                                          style: UIAlertController.Style) {
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: style)
        alert.addAction(UIAlertAction(title: "Продолжить", style: .cancel, handler: nil))
        target.present(alert, animated: true, completion: nil)
    }
}
