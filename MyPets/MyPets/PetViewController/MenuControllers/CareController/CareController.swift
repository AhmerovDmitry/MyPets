//
//  CareController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 05.03.2021.
//

import UIKit

class CareController: UIViewController, GeneralSetupProtocol {
    let models = [
        BaseModel(firstProperties: "Вычёсывание", secondProperties: "Уход за шерстью питомца"),
        BaseModel(firstProperties: "Стрижка", secondProperties: "Для длинношерстных животных"),
        BaseModel(firstProperties: "Стрижка когтей", secondProperties: "Чтобы никого и ничего не поцарапать"),
        BaseModel(firstProperties: "Чистка и уборка ушей", secondProperties: "Чтобы питомец был чистым и опрятным"),
        BaseModel(firstProperties: "Чистка зубов", secondProperties: "Чтобы питомец был чистым и опрятным"),
        BaseModel(firstProperties: "Купание", secondProperties: "Мытьё и сушка питомца")
    ]
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: "careCellId")
        return collectionView
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
