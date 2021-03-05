//
//  DocumentController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 05.03.2021.
//

import UIKit

class DocumentController: UIViewController, GeneralSetupProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupConstraints()
        setupElements()
        setupNavigationController()
    }
    
    func setupConstraints() {}
    func setupElements() {}
    func setupNavigationController() {}
    func presentController() {}
}
