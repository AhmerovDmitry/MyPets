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
						   colorOne: UIColor,
						   colorTwo: UIColor,
						   startPoint: CGPoint,
						   endPoint: CGPoint) {
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame = bounds
		gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
		gradientLayer.locations = [0.0, 1.0]
		gradientLayer.startPoint = startPoint
		gradientLayer.endPoint = endPoint
		view.layer.insertSublayer(gradientLayer, at: 0)
	}

	/// Метод добавляет тень в выбранном направлении
	func setDefaultShadow() {
		let shadowLayer = CAShapeLayer()
		shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: UIView.basicCornerRadius).cgPath
		shadowLayer.fillColor = UIColor.white.cgColor

		shadowLayer.shadowOffset = CGSize(width: 0, height: 0)
		shadowLayer.shadowRadius = 7
		shadowLayer.shadowColor = UIColor.CustomColor.dark.cgColor
		shadowLayer.shadowPath = shadowLayer.path
		shadowLayer.shadowOpacity = 0.2
		layer.insertSublayer(shadowLayer, at: 0)
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
	static let ninePartsScreenMultiplier: CGFloat = UIScreen.main.bounds.width / 1.1111111111
	static let basicCornerRadius: CGFloat = 16
}
