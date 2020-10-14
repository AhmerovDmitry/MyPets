//
//  MainViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 14.10.2020.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Главная"
        navigationController?.navigationBar.backgroundColor = .white
        
        view.backgroundColor = .white
        
        tabBarController?.tabBar.backgroundColor = .white
        tabBarItem.title = "Hello"
    }
}
