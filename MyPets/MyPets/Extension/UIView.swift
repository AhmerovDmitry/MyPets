//
//  UIView.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 12.10.2020.
//

import UIKit

extension UIView {
    private func setGradientBackground(colorOne: UIColor, colorTwo: UIColor, startPoint: CGPoint, endPoint: CGPoint) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        layer.insertSublayer(gradientLayer, at: 0)
    }
    /// Метод добавляет стандартную тень во все стороны от вью
    public func setDefaultShadow() {
        layer.shadowColor = UIColor.CustomColor.dark.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 7
        layer.cornerRadius = 16
    }
    /// Метод добавляет эффект размытия для вью
    public func setBlurEffect(_ view: UIView, frame: CGRect) {
        let blurEffect = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = frame
        view.insertSubview(effectView, at: 0)
    }
    func gradientSetup(view: UIView, colorOne: UIColor, colorTwo: UIColor) {
        view.setGradientBackground(
            colorOne: colorOne, colorTwo: colorTwo, startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1)
        )
    }
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
}
