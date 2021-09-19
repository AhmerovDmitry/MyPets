//
//  PremiumController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 08.08.2021.
//

import UIKit

protocol PremiumControllerDelegate: AnyObject {
    func dismissController(withPurchase: Bool)
}

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
        premiumView.delegate = self
        premiumView.tableViewDelegateAndDataSource(self)
    }

    private func updateCellContent(_ cell: UITableViewCell, index: Int) {
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .white
        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.text = premiumModel.description[index]
    }
}

extension PremiumController: PremiumControllerDelegate {
    func dismissController(withPurchase: Bool) {
        dismiss(animated: true, completion: nil)
        if withPurchase {
            self.userDefaultsService.setValue(true, forKey: .isAppPurchased)
            return
        }
    }
}

extension PremiumController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return premiumModel.description.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: premiumView.cellID, for: indexPath)
        updateCellContent(cell, index: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = tableView.frame.size.height / CGFloat(premiumModel.description.count)
        return cellHeight
    }
}
