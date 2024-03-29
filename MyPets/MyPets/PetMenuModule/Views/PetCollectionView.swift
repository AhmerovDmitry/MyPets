//
//  PetCollectionView.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 13.08.2021.
//

import UIKit

final class PetCollectionView: UIView {

    // MARK: - Property

    let cellID = "PetCollectionCell"

    private lazy var petCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(PetCollectionCell.self, forCellWithReuseIdentifier: cellID)
        return collectionView
    }()

    // MARK: - Init / Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private func setupUI() {
        setSelfUI()
        setPetCollectionConstraints()
    }
    private func setSelfUI() {
        self.backgroundColor = .white
    }
    private func setPetCollectionConstraints() {
        self.addSubview(petCollection)
        petCollection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            petCollection.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            petCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            petCollection.leftAnchor.constraint(equalTo: self.leftAnchor),
            petCollection.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
}

// MARK: - Public Methods

extension PetCollectionView {
    func collectionViewDelegate<T: UICollectionViewDelegate>(_ target: T) {
        petCollection.delegate = target
    }
    func collectionViewDataSource<T: UICollectionViewDataSource>(_ target: T) {
        petCollection.dataSource = target
    }
    func reloadCollectionView() {
        self.petCollection.reloadData()
    }
}
