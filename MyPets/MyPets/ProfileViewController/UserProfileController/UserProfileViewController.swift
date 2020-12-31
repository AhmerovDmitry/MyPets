//
//  UserProfileViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 31.12.2020.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationController()
    }
    
    func setupNavigationController() {
        let backButton = UIBarButtonItem()
        backButton.title = " "
        
        navigationController?.navigationItem.backBarButtonItem = backButton
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = UIColor.CustomColor.dark
    }
}
