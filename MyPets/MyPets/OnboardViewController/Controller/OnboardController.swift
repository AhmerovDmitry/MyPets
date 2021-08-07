//
//  OnboardController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 03.08.2021.
//

import UIKit

final class OnboardController: UIViewController {
    // MARK: - Properties
    private let onboardContent = OnboardModel()
    private lazy var onboardView = OnboardView(frame: self.view.frame)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onboardView.getOnboardContent(onboardContent)
        view.addSubview(onboardView)
    }
}
