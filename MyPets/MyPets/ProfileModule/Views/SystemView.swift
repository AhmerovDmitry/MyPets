//
//  SystemProfileView.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 13.09.2021.
//

import UIKit

final class SystemView: UIView {
    private var systemModel: SystemModelProtocol
    private var userDefaultsService: UserDefaultsServiceProtocol

    private let systemTableViewCellID = "systemTableViewCellID"
    private lazy var systemTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: systemTableViewCellID)
        return tableView
    }()

    init(userDefaultsService: UserDefaultsServiceProtocol) {
        self.systemModel = SystemModel()
        self.userDefaultsService = userDefaultsService
        super.init(frame: CGRect(x: 0, y: 0,
                                 width: Int(UIScreen.main.bounds.width),
                                 height: systemModel.systemTitleContent.count * Int(UITableViewCell.heightSubRow)))
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SystemView {
    private func setupUI() {
        setSystemTableViewConstraints()
    }
    private func setSystemTableViewConstraints() {
        self.addSubview(systemTableView)
        systemTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            systemTableView.topAnchor.constraint(equalTo: self.topAnchor),
            systemTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            systemTableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            systemTableView.rightAnchor.constraint(equalTo: self.rightAnchor),
        ])
    }
}

extension SystemView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return systemModel.systemTitleContent.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: systemTableViewCellID, for: indexPath)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .light)
        cell.textLabel?.tintColor = UIColor.CustomColor.darkGray
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.text = systemModel.systemTitleContent[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: resetLaunchStatus()
        case 1: resetPurchase()
        default: break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewCell.heightSubRow
    }
    func resetLaunchStatus() {
        userDefaultsService.setValue(false, forKey: .isNotFirstLaunch)
        debugPrint("Статус запуска приложения сброшен")
    }
    func resetPurchase() {
        userDefaultsService.setValue(false, forKey: .isAppPurchased)
        debugPrint("Статус покупки приложения сброшен")
    }
}
