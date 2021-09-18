//
//  PremiumController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 08.08.2021.
//

import UIKit

final class PremiumController: UIViewController {
    private let userDefaultsService: UserDefaultsService

    private let premiumModel: PremiumModelProtocol
    private let premiumView: PremiumView

    init(userDefaultsService: UserDefaultsService) {
        self.userDefaultsService = userDefaultsService
        self.premiumModel = PremiumModel()
        self.premiumView = PremiumView(frame: UIScreen.main.bounds)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        view = premiumView
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViewContent()
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

    private func updateViewContent() {
        premiumView.getPremiumContent(premiumModel)
    }
}
