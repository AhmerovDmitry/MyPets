//
//  FoodController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 05.03.2021.
//

import UIKit

class FoodController: UIViewController, GeneralSetupProtocol {
    let models = [
        BaseModel(firstProperties: "Корм", secondProperties: "Сухой / влажный корм"),
        BaseModel(firstProperties: "Добавки", secondProperties: "Витамины и добавки")
    ]
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(MenuCell.self, forCellWithReuseIdentifier: "foodCellId")
        
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
