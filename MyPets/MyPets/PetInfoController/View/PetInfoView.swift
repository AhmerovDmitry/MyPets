//
//  PetInfoView.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 13.08.2021.
//

import UIKit

final class PetInfoView: UIView {
    // MARK: - Initialization & Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        presentInputInfoController()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Properties
    public var presentControllerCallBack: (() -> Void)?
    private let cellID = "PetInfoCell"
    private let petImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "unknownImage")
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .white
        image.clipsToBounds = true
        return image
    }()
    private lazy var petInfoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PetInfoCollectionCell.self, forCellWithReuseIdentifier: cellID)
        return collectionView
    }()
    private let petInfoCell = PetInfoCell()
}

// MARK: - Setup UI
extension PetInfoView {
    private func setupUI() {
        self.backgroundColor = .white
        setPetImageConstraints()
        setPetInfoCollectionViewConstraints()
    }
    private func setPetImageConstraints() {
        self.addSubview(petImage)
        petImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            petImage.widthAnchor.constraint(equalTo: self.widthAnchor),
            petImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            petImage.topAnchor.constraint(equalTo: self.topAnchor),
            petImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3)
        ])
    }
    private func setPetInfoCollectionViewConstraints() {
        self.addSubview(petInfoCollectionView)
        petInfoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            petInfoCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            petInfoCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            petInfoCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            petInfoCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    private func setPetInfoCollectionInCell(_ cell: UICollectionViewCell) {
        cell.addSubview(petInfoCell)
        petInfoCell.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            petInfoCell.topAnchor.constraint(equalTo: cell.topAnchor),
            petInfoCell.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
            petInfoCell.leftAnchor.constraint(equalTo: cell.leftAnchor),
            petInfoCell.rightAnchor.constraint(equalTo: cell.rightAnchor)
        ])
    }
}

// MARK: - Actions
extension PetInfoView {
    @objc private func presentController() {}
}

// MARK: - Delegate & DataSource
extension PetInfoView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            return CGSize(width: self.bounds.width / 1.1, height: self.bounds.height / 1.7)
        default:
            return CGSize(width: self.bounds.width / 1.1, height: self.bounds.height / 9)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellID,
            for: indexPath
        ) as? PetInfoCollectionCell else { return UICollectionViewCell() }
        indexPath.row == 0 ? setPetInfoCollectionInCell(cell) : nil
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: petImage.bounds.height / 3, left: 0, bottom: 15, right: 0)
    }
}

// MARK: - Public Methods
extension PetInfoView {
    public func presentInputInfoController() {
        petInfoCell.presentControllerCallBack = { [weak self] in
            self?.presentControllerCallBack?()
        }
    }
    public func configureCell(_ data: Any?) {
        petInfoCell.configureCell(data)
    }
}
