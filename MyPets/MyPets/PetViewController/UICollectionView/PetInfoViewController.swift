//
//  PetInfoViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 28.10.2020.
//

import UIKit

class PetInfoViewController: UIViewController {
    private let titleImage = UIImageView()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(PetViewCollectionCell.self, forCellWithReuseIdentifier: "collectionCellPetId")
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = .clear
        
        view.backgroundColor = .white
        
        setupConstraint()
        setupViewsAndLabels()
    }
}

extension PetInfoViewController: GeneralSetupProtocol {
    func setupConstraint() {
        view.addSubview(titleImage)
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        titleImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        titleImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        titleImage.heightAnchor.constraint(lessThanOrEqualToConstant: 300).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: titleImage.bottomAnchor,
                                            constant: -64).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor,
                                             constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor,
                                              constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupViewsAndLabels() {
        titleImage.translatesAutoresizingMaskIntoConstraints = false
        titleImage.contentMode = .scaleAspectFill
        titleImage.image = UIImage(named: "titleImage")
    }
    
    func presentController() {
        
    }
    
    
}
