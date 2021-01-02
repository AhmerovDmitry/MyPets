//
//  UserProfileViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 31.12.2020.
//

import UIKit

class UserProfileViewController: UIViewController {

    var models = [
        PetTableViewModel(title: "Имя", info: "Указать информацию"),
        PetTableViewModel(title: "Город", info: "Указать информацию"),
        PetTableViewModel(title: "E-mail", info: "Указать информацию")
    ]
    let profileView = UIImageView()
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PetViewTableCell.self,
                           forCellReuseIdentifier: "userProfileCell")
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = false
        
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
        let backButton = UIBarButtonItem()
        backButton.title = " "
        
        navigationController?.navigationItem.backBarButtonItem = backButton
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = UIColor.CustomColor.dark
    }
}

extension UserProfileViewController: GeneralSetupProtocol {
    func setupConstraints() {
        view.addSubview(profileView)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            profileView.heightAnchor.constraint(equalToConstant: view.bounds.height / 10),
            profileView.widthAnchor.constraint(equalTo: profileView.heightAnchor),
            profileView.topAnchor.constraint(equalTo: view.topAnchor,
                                             constant: (navigationController?.navigationBar.bounds.height)!),
            profileView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: profileView.bottomAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.heightAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    func setupElements() {
        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileView.clipsToBounds = true
        profileView.image = UIImage(named: "cameraIcon")
        profileView.setImageColor(color: .white)
        profileView.contentMode = .center
        profileView.backgroundColor = UIColor.CustomColor.gray
        profileView.layoutIfNeeded()
        profileView.layer.cornerRadius = profileView.bounds.height / 2
    }
    
    func presentController() {
    }
    
    
}
