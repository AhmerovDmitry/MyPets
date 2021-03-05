//
//  MainViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 14.10.2020.
//

import UIKit

class MainViewController: UIViewController, GeneralSetupProtocol {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupConstraints()
        setupElements()
        setupNavigationController()
    }
    
    func setupConstraints() {
    }
    
    func setupElements() {
    }
    
    func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.CustomColor.dark]
        navigationItem.title = "Главная"
    }
    
    func presentController() {
    }
}
