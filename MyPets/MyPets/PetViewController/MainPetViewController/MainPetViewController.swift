//
//  MainPetViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 15.10.2020.
//

import UIKit

class MainPetViewController: UIViewController {
    static let shared = MainPetViewController()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    lazy var pets = [PetEntity]()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(EntityCell.self, forCellWithReuseIdentifier: "entityCell")
        cv.isHidden = true
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        loadPets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        switch pets.isEmpty {
        case true: viewWithoutPet()
        case false: viewWithPet()
        }
    }
}
