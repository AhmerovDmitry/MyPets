//
//  UIImageView.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 02.01.2021.
//

import UIKit

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}
