//
//  PetInfoCell.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 13.08.2021.
//

import UIKit

final class PetInfoCell: UIView {
    // MARK: - Initialization & Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Properties
    private let petNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.CustomColor.dark
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "Карточка питомца"
        return label
    }()
    private let petInfoTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.isScrollEnabled = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
        return tableView
    }()
}
// MARK: - Setup UI
extension PetInfoCell {
    private func setupUI() {
        self.layer.cornerRadius = UIView.basicCornerRadius
        self.clipsToBounds = true
        self.backgroundColor = .white
        setPetNameLabelConstraints()
        setPetInfoTableConstraints()
    }
    private func setPetNameLabelConstraints() {
        self.addSubview(petNameLabel)
        petNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            petNameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            petNameLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1),
            petNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            petNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15)
        ])
    }
    private func setPetInfoTableConstraints() {
        self.addSubview(petInfoTable)
        petInfoTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            petInfoTable.topAnchor.constraint(equalTo: petNameLabel.bottomAnchor),
            petInfoTable.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            petInfoTable.leftAnchor.constraint(equalTo: self.leftAnchor),
            petInfoTable.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
}
// MARK: - Public Methods
extension PetInfoCell {
    /// Методы делегата и дата сорса, которые передаются в контроллер для работы с ними
    func tableViewDelegate<T: UITableViewDelegate>(_ target: T) {
        petInfoTable.delegate = target
    }
    func tableViewDataSource<T: UITableViewDataSource>(_ target: T) {
        petInfoTable.dataSource = target
    }
    /// Регистрация ячейки с использованием идентификатора
    func setTableViewID(_ id: String) {
        petInfoTable.register(PetInfoTableCell.self, forCellReuseIdentifier: id)
    }
    /// Перезагрузка одной ячейки после изменения значения в ней
    func reloadTableViewCell(at indexPath: IndexPath) {
        petInfoTable.reloadRows(at: [indexPath], with: .none)
    }
}
