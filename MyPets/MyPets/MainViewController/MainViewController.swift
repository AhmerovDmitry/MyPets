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
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.CustomColor.dark]
        navigationItem.title = "Главная"
        
        view.backgroundColor = .white
        
        setupConstraints()
        setupElements()
    }
    
    func setupConstraints() {
    }
    
    func setupElements() {
    }
    
    func presentController() {
    }
}
