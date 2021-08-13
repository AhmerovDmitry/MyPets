//
//  PetCollectionView.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 13.08.2021.
//

import UIKit

final class PetCollectionView: UIView {
    // MARK: - Initialization & Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Properties
    private let cellID = "PetCollectionCell"
    private lazy var petCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PetCollectionCell.self, forCellWithReuseIdentifier: cellID)
        return collectionView
    }()
}

// MARK: - Setup UI
extension PetCollectionView {
    private func setupUI() {
        self.backgroundColor = .white
        setPetCollectionConstraints()
    }
    private func setPetCollectionConstraints() {
        self.addSubview(petCollection)
        petCollection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            petCollection.topAnchor.constraint(equalTo: self.topAnchor),
            petCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            petCollection.leftAnchor.constraint(equalTo: self.leftAnchor),
            petCollection.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
}

// MARK: - Actions
extension PetCollectionView {
    @objc private func presentController() {}
}

// MARK: - Delegate & DataSource
extension PetCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.bounds.width / 1.1, height: self.bounds.height / 3.5)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellID,
            for: indexPath
        ) as? PetCollectionCell else { return UICollectionViewCell() }
        cell.configureCell(
            image: UIImage(),
            name: "Name",
            breed: "Breed",
            age: "Age"
        )
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
    }
}

// MARK: - Public Methods
extension PetCollectionView {
    public func getPetCollectionContent(_ content: Any) {
    }
}
