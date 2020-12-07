//
//  ProfileViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 15.10.2020.
//

import UIKit

class ProfileViewController: UIViewController, GeneralSetupProtocol {
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "profileCell")
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.CustomColor.dark]
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Профиль"
        
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupConstraints()
        setupElements()
    }
    
    func setupConstraints() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor,
                                           constant: (navigationController?.navigationBar.bounds.height)!),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                              constant: -(tabBarController?.tabBar.bounds.height)!)
        ])
    }
    
    func setupElements() {
    }
    
    func presentController() {
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//            let titles = ["",
//                          "",
//                          "УВЕДОМЛЕНИЯ",
//                          "Неограниченное количество питомцев и множество дополнительных функций доступно в Premium",
//                          "",
//                          ""]
            let titles = ["",
                          "",
                          "УВЕДОМЛЕНИЯ",
                          "",
                          "",
                          ""]
    
            return titles[section]
        }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0, 3, 5:
            return 1
        default:
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath)
        
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = "Cell - \(indexPath.row)"
            cell.contentConfiguration = content
        } else {
            cell.textLabel?.text = "Cell - \(indexPath.row)"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
