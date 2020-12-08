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
