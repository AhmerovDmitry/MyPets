//
//  UIImage.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 25.03.2021.
//

import UIKit

extension UIImage {
    func toString() -> String? {
        let data: Data? = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}
