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
    private let onboardView = OnboardView(frame: UIScreen.main.bounds)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViewContent()
        addSubview()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        onboardView.presentControllerCallBack = { [weak self] in
            let tabBarController = CustomTabBarController()
            tabBarController.viewControllers = tabBarController.controllers
            tabBarController.modalPresentationStyle = .fullScreen
            self?.present(tabBarController, animated: true, completion: nil)
            
            UserDefaults.standard.set(true, forKey: "isFirstLaunch")
        }
    }
    
    private func updateViewContent() {
        onboardView.getOnboardContent(onboardContent)
    }
    private func addSubview() {
        view.addSubview(onboardView)
    }
}
