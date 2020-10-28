//
//  ProfileViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 15.10.2020.
//

import UIKit

class ProfileViewController: UIViewController, GeneralSetupProtocol {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.CustomColor.dark]
        navigationItem.title = "Профиль"
        
        view.backgroundColor = .white
        setup()
    }
    
    func setup() {
        setupConstraint()
        setupViewsAndLabels()
    }
    
    func setupConstraint() {
    }
    
    func setupViewsAndLabels() {
    }
    
    func presentController() {
    }
}
