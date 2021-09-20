//
//  UIButton.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 12.10.2020.
//

import UIKit

extension UIButton {

    // Расширение для стандартной кнопки

    static func createTypicalButton(title: String,
                                    backgroundColor: UIColor,
                                    borderWidth: CGFloat?,
                                    target: Any?,
                                    action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = backgroundColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.addTarget(target, action: action, for: .touchUpInside)
        if let width = borderWidth {
            button.layer.borderWidth = width
            button.layer.borderColor = UIColor.CustomColor.purple.cgColor
        }
        if backgroundColor == .white {
            button.setTitleColor(UIColor.CustomColor.purple, for: .normal)
        } else {
            button.setTitleColor(.white, for: .normal)
        }

        return button
    }
}
