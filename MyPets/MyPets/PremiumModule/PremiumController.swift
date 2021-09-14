//
//  PremiumController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 08.08.2021.
//

import UIKit

final class PremiumController: UIViewController {
    // MARK: - Properties
    private let userDefaultsService: UserDefaultsServiceProtocol
    private let premiumContent = PremiumModel()
    private let premiumView = PremiumView(frame: UIScreen.main.bounds)

    // MARK: - Lifecycle
    init(userDefaultsService: UserDefaultsServiceProtocol) {
        self.userDefaultsService = userDefaultsService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewContent()
        addSubview()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        premiumView.presentControllerCallBack = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true, completion: nil)
            self.userDefaultsService.setValue(true, forKey: .isAppPurchased)
        }
        premiumView.dismissControllerCallBack = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true, completion: nil)
            self.userDefaultsService.setValue(false, forKey: .isAppPurchased)
        }
    }
}
// MARK: - Methods
extension PremiumController {
    private func updateViewContent() {
        premiumView.getOnboardContent(premiumContent)
    }
    private func addSubview() {
        view.addSubview(premiumView)
    }
}
