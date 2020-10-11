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
        let onboardView = OnboardViewController()
        onboardView.modalPresentationStyle = .fullScreen
        present(onboardView, animated: true, completion: nil)
    }
}
