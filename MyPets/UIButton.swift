//
//  UIButton.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 12.10.2020.
//

import UIKit

extension UIButton {
    func setBackgroundColor(_ color: UIColor, forState controlState: UIControl.State) {
        let colorImage = UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1)).image { _ in
            color.setFill()
            UIBezierPath(rect: CGRect(x: 0, y: 0, width: 1, height: 1)).fill()
        }
        setBackgroundImage(colorImage, for: controlState)
    }
    
    func setFrame() {
        let buttonSize = self.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        self.frame.size = CGSize(width: buttonSize.height * 1.5,
                                 height: buttonSize.height * 1.5)
        self.layer.cornerRadius = self.frame.height / 2
    }
}
