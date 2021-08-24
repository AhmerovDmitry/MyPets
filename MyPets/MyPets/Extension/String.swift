//
//  String.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 25.03.2021.
//

import UIKit

extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters) {
            return UIImage(data: data)
        }
        return nil
    }
}
