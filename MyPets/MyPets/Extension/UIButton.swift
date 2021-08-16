//
//  UIButton.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 12.10.2020.
//

import UIKit

extension UIButton {
    static func createStandartButton(title: String, backgroundColor: UIColor, action: Selector, target: Any?) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = backgroundColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.layer.borderWidth = 1
        if button.backgroundColor == .white {
            button.setTitleColor(UIColor.CustomColor.purple, for: .normal)
            button.layer.borderColor = UIColor.CustomColor.purple.cgColor
        } else {
            button.setTitleColor(.white, for: .normal)
            button.layer.borderColor = UIColor.white.cgColor
        }
        button.addTarget(target, action: action, for: .touchUpInside)
        return button
    }
}
