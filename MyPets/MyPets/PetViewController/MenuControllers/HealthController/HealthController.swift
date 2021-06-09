//
//  HealthController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 05.03.2021.
//

import UIKit

class HealthController: UIViewController, GeneralSetupProtocol {
    
    let models = [
        BaseModel(firstProperties: "Моя ветклиника", secondProperties: "Адрес, телефон, график работы"),
        BaseModel(firstProperties: "Дегельминтизация", secondProperties: "Лекарственные препараты, календарь"),
        BaseModel(firstProperties: "Обработка от блох и клещей", secondProperties: "Лекарственные препараты, календарь"),
        BaseModel(firstProperties: "Вакцинация", secondProperties: "Обязательные и рекомендуемые прививки"),
        BaseModel(firstProperties: "Заболевания", secondProperties: "Болезни питомца и лечение"),
    ]
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(MenuCell.self, forCellWithReuseIdentifier: "healthCellId")
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupConstraints()
        setupElements()
        setupNavigationController()
    }
    
    func setupConstraints() {
        view.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupElements() {}
    func setupNavigationController() {}
    func presentController() {}
    
}
