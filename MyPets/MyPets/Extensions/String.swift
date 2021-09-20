//
//  String.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 19.09.2021.
//

import Foundation

extension StringProtocol {
    var firstUppercased: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
}
