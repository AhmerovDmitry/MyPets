//
//  ProfileViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 15.10.2020.
//

import UIKit

class ProfileViewController: UIViewController, GeneralSetupProtocol {
    var userImage: UIImage?
    var userInfo = UserProfileModel()
    let menuTitles: [[String]] = [
        ["Имя пользователя"],
        ["Питомцы", "Архив"],
        ["Подсказки и советы", "Напоминания"],
        ["MyPets Premium"],
        ["Поддержка", "О приложении", "Skip_launch_status", "Skip_paid_status", "Remove_first_entity"]
    ]
    let tipsSwitch = UISwitch()
    let reminderSwitch = UISwitch()
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.register(ProfileViewCell.self,
                           forCellReuseIdentifier: "profileCell")
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        setupNavigationController()
        setupConstraints()
        setupElements()
    }
    func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.CustomColor.dark]
        navigationItem.title = "Профиль"
    }
    func setupConstraints() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    func setupElements() {
        [tipsSwitch, reminderSwitch].forEach { switchs in
            switchs.translatesAutoresizingMaskIntoConstraints = false
            switchs.isOn = true
        }
    }
}
