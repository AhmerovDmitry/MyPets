//
//  UIView.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 12.10.2020.
//

import UIKit

extension UIView {
    /// Эффект градиента для вью
    /// Направление вью задается startPoint и endPoint
    /// - Parameters:
    ///   - view: Вью на которую накладывается градиент
    ///   - colorOne: Первый цвет градиента
    ///   - colorTwo: Второй цвет градиента
    ///   - startPoint: Стартовая точка откуда пойдет градиент
    ///   - endPoint: Конечная точка где закончится градиент
    func setGradientEffect(_ view: UIView,
                           colorOne: UIColor, colorTwo: UIColor,
                           startPoint: CGPoint, endPoint: CGPoint) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    /// Метод добавляет тень во все стороны от вью
    func setDefaultShadow() {
        layer.shadowColor = UIColor.CustomColor.dark.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 7
        layer.cornerRadius = UIView.basicCornerRadius
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }

    /// Добавление эффекта размытия на вью
    /// - Parameters:
    ///   - view: Вью на которую накладывается размытие
    ///   - frame: Размер этой вью для сопоставления эффекта размытия со вью
    func setBlurEffect(_ view: UIView, frame: CGRect) {
        let blurEffect = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = frame
        view.insertSubview(effectView, at: 0)
    }

    /// Число для определения 0.9 части экрана (примерное)
    static let ninePartsScreenMultiplier: CGFloat = 1.1111111111
    static let basicCornerRadius: CGFloat = 16

    /*
    /// Анимация тряски вью, возможно не понадобится и прийдется удалить
    func startShakeAnimation() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.1
        animation.repeatCount = .infinity
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    func stopShakeAnimation() {
        self.layer.removeAnimation(forKey: "position")
    }
    */
}
