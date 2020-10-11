//
//  @objc Extension.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 11.10.2020.
//

import UIKit

@objc
extension AuthorizationViewController {
    func pushOnboard() {
        present(OnboardViewController(), animated: true, completion: nil)
    }
}
