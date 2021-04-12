//
//  MainViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 14.10.2020.
//

import UIKit

class MainViewController: UIViewController, GeneralSetupProtocol {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(MainCollectionCell.self, forCellWithReuseIdentifier: "mainCell")
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        
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
    }
    
    func setupElements() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.1)
        ])
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
