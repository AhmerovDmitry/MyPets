//
//  PetInfoTableCell.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 16.08.2021.
//

import UIKit

final class PetInfoTableCell: UITableViewCell {
    private let cellLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.CustomColor.dark
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let cellPlaceholder: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = UIColor.CustomColor.gray
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PetInfoTableCell {
    private func setupUI() {
        self.backgroundColor = .white
        setCellLabelConstraints()
        setCellPlaceholderConstraints()
    }
    private func setCellLabelConstraints() {
        self.addSubview(cellLabel)
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellLabel.topAnchor.constraint(equalTo: self.topAnchor),
            cellLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            cellLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            cellLabel.rightAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    private func setCellPlaceholderConstraints() {
        self.addSubview(cellPlaceholder)
        cellPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellPlaceholder.topAnchor.constraint(equalTo: self.topAnchor),
            cellPlaceholder.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            cellPlaceholder.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            cellPlaceholder.leftAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}

extension PetInfoTableCell {
    func configureTitle(_ value: String?) {
        cellLabel.text = value
    }
    func configurePlaceholder(_ value: String?) {
        guard let value = value else {
            cellPlaceholder.text = "Укажите информацию"
            return
        }
        cellPlaceholder.text = value
    }
}
