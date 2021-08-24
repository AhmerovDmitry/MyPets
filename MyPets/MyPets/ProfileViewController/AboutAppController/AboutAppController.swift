//
//  AboutAppController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 16.01.2021.
//

import UIKit

class AboutAppController: UIViewController {
    let appVersion: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Версия приложения: \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "")"
        label.textAlignment = .center
        label.textColor = UIColor.CustomColor.dark
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    let designerInfo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Дизайнер: Екатерина Лемина"
        label.textAlignment = .center
        label.textColor = UIColor.CustomColor.dark
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    let developerInfo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Разработчик: Дмитрий Ахмеров"
        label.textAlignment = .center
        label.textColor = UIColor.CustomColor.dark
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
        [appVersion, designerInfo, developerInfo].forEach { view.addSubview($0) }
        NSLayoutConstraint.activate([
            appVersion.leftAnchor.constraint(equalTo: view.leftAnchor),
            appVersion.rightAnchor.constraint(equalTo: view.rightAnchor),
            appVersion.bottomAnchor.constraint(equalTo: designerInfo.topAnchor),
            designerInfo.leftAnchor.constraint(equalTo: view.leftAnchor),
            designerInfo.rightAnchor.constraint(equalTo: view.rightAnchor),
            designerInfo.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            developerInfo.topAnchor.constraint(equalTo: designerInfo.bottomAnchor),
            developerInfo.leftAnchor.constraint(equalTo: view.leftAnchor),
            developerInfo.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        print(developerInfo.bounds.height)
        setupNavigationController()
    }
    func setupNavigationController() {
        navigationController?.navigationBar.tintColor = UIColor.CustomColor.dark
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.CustomColor.dark]
        navigationItem.title = "О приложении"
    }
}
