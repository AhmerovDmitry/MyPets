//
//  PetMenuController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 12.08.2021.
//

import UIKit

final class PetMenuController: UIViewController {
    // MARK: - Properties
    private let petMenuView = PetMenuView(frame: UIScreen.main.bounds)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        addSubview()
    }
    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.CustomColor.dark]
        navigationItem.title = "Питомцы"
    }
    private func addSubview() {
        view.addSubview(petMenuView)
    }
}

