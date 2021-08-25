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
        petInfoCell.setTableViewID(tableCellID)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Properties
    public let tableCellID = "PetTableCell"
    public let collectionCellID = "PetCollectionCell"
    private let petInfoCell = PetInfoCell()
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
        collectionView.register(PetInfoCollectionCell.self, forCellWithReuseIdentifier: collectionCellID)
        return collectionView
    }()
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
}
// MARK: - Public Methods
extension PetInfoView {
    /// Метод задает первоя ячейке в коллекции кастомную ячейку в виде таблицы с информацией
    /// которую должен заполнять пользователь
    public func setPetInfoCollectionInCell(_ cell: UICollectionViewCell) {
        cell.addSubview(petInfoCell)
        petInfoCell.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            petInfoCell.topAnchor.constraint(equalTo: cell.topAnchor),
            petInfoCell.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
            petInfoCell.leftAnchor.constraint(equalTo: cell.leftAnchor),
            petInfoCell.rightAnchor.constraint(equalTo: cell.rightAnchor)
        ])
    }
    /// Методы делегата и дата сорса, которые передаются в контроллер для работы с ними
    public func collectionViewDelegate<T: UICollectionViewDelegate>(_ target: T) {
        petInfoCollectionView.delegate = target
    }
    public func collectionViewDataSource<T: UICollectionViewDataSource>(_ target: T) {
        petInfoCollectionView.dataSource = target
    }
    /// Методы делегата и дата сорса, которые передаются в контроллер для работы с ними
    public func tableViewDelegateAndDataSource<T>(_ target: T) where T: UITableViewDelegate, T: UITableViewDataSource {
        petInfoCell.tableViewDelegate(target)
        petInfoCell.tableViewDataSource(target)
    }
    /// Перезагрузка одной ячейки после изменения значения в ней
    public func reloadTableViewCell(at indexPath: IndexPath) {
        petInfoCell.reloadTableViewCell(at: indexPath)
    }
}
