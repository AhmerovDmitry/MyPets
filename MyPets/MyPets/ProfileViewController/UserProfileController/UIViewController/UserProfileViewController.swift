//
//  UserProfileViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 31.12.2020.
//

import UIKit

class UserProfileViewController: UIViewController {
    var userInfo = UserProfileModel()
    var indexPath = IndexPath()
    weak var delegate: ProfileViewControllerDelegate?
    var models = [
        BaseModel(firstProperties: "Имя", secondProperties: "Указать информацию"),
        BaseModel(firstProperties: "Город", secondProperties: "Указать информацию"),
        BaseModel(firstProperties: "E-mail", secondProperties: "Указать информацию")
    ]
    let profileView = UIButton(type: .system)
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
        navigationController?.navigationBar.tintColor = UIColor.CustomColor.dark
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.CustomColor.dark]
        navigationItem.title = "Профиль"
    }
}

extension UserProfileViewController: GeneralSetupProtocol {
    func setupConstraints() {
        view.addSubview(profileView)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            profileView.heightAnchor.constraint(equalToConstant: view.bounds.height / 10),
            profileView.widthAnchor.constraint(equalTo: profileView.heightAnchor),
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
        profileView.setImage(UIImage(named: "cameraIcon"), for: .normal)
        profileView.tintColor = .white
        profileView.contentMode = .center
        profileView.backgroundColor = UIColor.CustomColor.gray
        profileView.layoutIfNeeded()
        profileView.layer.cornerRadius = profileView.bounds.height / 2
        profileView.addTarget(self, action: #selector(presentController), for: .touchUpInside)
        profileView.setBackgroundImage(UIImage(data: userInfo.image ?? Data()), for: .normal)
    }
    
}

extension UserProfileViewController: UITextFieldDelegate {
    func alertForUserInformation(title: String,
                                 message: String,
                                 textFieldIndex: IndexPath) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.indexPath = textFieldIndex
        alert.addTextField { textField in
            textField.textAlignment = .left
            textField.textColor = UIColor.CustomColor.dark
            textField.placeholder = "Введите информацию о питомце"
            textField.addTarget(self, action: #selector(self.textFieldDidChangeSelection(_:)), for: .editingChanged)
        }
        let saveButton = UIAlertAction(title: "Сохранить", style: .default) { _ in
            switch self.indexPath.row {
            case 0:
                self.userInfo.name = self.models[self.indexPath.row].secondProperties
            case 1:
                self.userInfo.city = self.models[self.indexPath.row].secondProperties
            case 2:
                self.userInfo.eMail = self.models[self.indexPath.row].secondProperties
            default: break
            }
            self.delegate?.updateUser(profile: self.userInfo)
            self.tableView.reloadData()
        }
        let cancelButton = UIAlertAction(title: "Отменить", style: .cancel)
        alert.addAction(saveButton)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        models[indexPath.row].secondProperties = textField.text
    }
    
}
