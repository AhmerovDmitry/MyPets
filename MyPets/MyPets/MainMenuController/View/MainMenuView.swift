//
//  MainMenuView.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 11.08.2021.
//

import UIKit

final class MainMenuView: UIView {
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
    private let cellID = "MainMenuCell"
    
    private let titleMenuView = TitleMenuView()
    private lazy var generalMenuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        return collectionView
    }()
}

// MARK: - Setup UI
extension MainMenuView {
    private func setupUI() {
        self.backgroundColor = .white
        setTitleMenuViewConstraints()
        setGeneralMenuCollectionViewConstraints()
    }
    private func setTitleMenuViewConstraints() {
        self.addSubview(titleMenuView)
        titleMenuView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleMenuView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            titleMenuView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleMenuView.heightAnchor.constraint(equalToConstant: self.bounds.height / 6),
            titleMenuView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9)
        ])
    }
    private func setGeneralMenuCollectionViewConstraints() {
        self.addSubview(generalMenuCollectionView)
        generalMenuCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            generalMenuCollectionView.topAnchor.constraint(equalTo: titleMenuView.bottomAnchor, constant: 12),
            generalMenuCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            generalMenuCollectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            generalMenuCollectionView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9)
        ])
    }
}

// MARK: - Actions
extension MainMenuView {
}

// MARK: - Delegate & DataSource
extension MainMenuView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: self.bounds.height / 6)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        cell.backgroundColor = .red
        cell.layer.cornerRadius = 16
        return cell
    }
}
