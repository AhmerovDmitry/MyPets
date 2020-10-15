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
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.title = "Главная"
        
        view.backgroundColor = .white
    }
}
