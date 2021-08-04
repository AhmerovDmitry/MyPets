//
//  OnboardController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 03.08.2021.
//

import UIKit

final class OnboardController: UIViewController {
    
    private let onboardContent = OnboardModel.shared
    private lazy var onboardView = OnboardView(frame: self.view.frame)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onboardView.getOnboardContent(onboardContent)
        view.addSubview(onboardView)
    }
    
}
