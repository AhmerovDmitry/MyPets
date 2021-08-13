//
//  PremiumController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 08.08.2021.
//

import UIKit

final class PremiumController: UIViewController {
    // MARK: - Properties
    private let premiumContent = PremiumModel()
    private let premiumView = PremiumView(frame: UIScreen.main.bounds)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViewContent()
        addSubview()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        premiumView.presentControllerCallBack = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
            UserDefaults.standard.setValue(true, forKey: "paidStatus")
        }
        premiumView.dismissControllerCallBack = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    private func updateViewContent() {
        premiumView.getOnboardContent(premiumContent)
    }
    private func addSubview() {
        view.addSubview(premiumView)
    }
}
