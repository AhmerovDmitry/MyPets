//
//  UIButton.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 12.10.2020.
//

import UIKit

final class TypicalProjectButtonBuilder {
    private var title: String?
    private var titleColor: UIColor?
    private var backgroundColor: UIColor?
    private var font: UIFont?
    private var adjustsFontSizeToFitWidth: Bool?
    private var borderWidth: CGFloat?
    private var borderColor: CGColor?
    private var action: Selector?
    private var target: Any?

    func with(title: String) -> TypicalProjectButtonBuilder {
        self.title = title
        return self
    }
    func with(titleColor: UIColor) -> TypicalProjectButtonBuilder {
        self.titleColor = titleColor
        return self
    }
    func with(backgroundColor: UIColor) -> TypicalProjectButtonBuilder {
        self.backgroundColor = backgroundColor
        return self
    }
    func with(font: UIFont) -> TypicalProjectButtonBuilder {
        self.font = font
        return self
    }
    func with(adjustsFontSizeToFitWidth: Bool) -> TypicalProjectButtonBuilder {
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        return self
    }
    func with(borderWidth: CGFloat) -> TypicalProjectButtonBuilder {
        self.borderWidth = borderWidth
        return self
    }
    func with(borderColor: CGColor) -> TypicalProjectButtonBuilder {
        self.borderColor = borderColor
        return self
    }
    func with(_ target: Any, action: Selector) -> TypicalProjectButtonBuilder {
        self.target = target
        self.action = action
        return self
    }

    func build() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.titleLabel?.font = font
        button.titleLabel?.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth ?? false
        button.layer.borderWidth = borderWidth ?? 0
        button.layer.borderColor = borderColor ?? UIColor.clear.cgColor
        if let action = action {
            button.addTarget(target, action: action, for: .touchUpInside)
        }
        return button
    }
}
