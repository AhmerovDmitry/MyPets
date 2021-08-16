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
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Properties
    public var presentControllerCallBack: (() -> Void)?
    private var petMenuTitles: [String]?
    private let cellID = "petTableCell"
    private let petNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.CustomColor.dark
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "PetNameLabel"
        return label
    }()
    private lazy var petInfoTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PetInfoTableCell.self, forCellReuseIdentifier: cellID)
        return tableView
    }()
}

// MARK: - Setup UI
extension PetInfoCell {
    private func setupUI() {
        self.layer.cornerRadius = 16
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
            petInfoTable.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 1),
            petInfoTable.leftAnchor.constraint(equalTo: self.leftAnchor),
            petInfoTable.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
}

// MARK: - Delegate & DataSource
extension PetInfoCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let count = petMenuTitles?.count else { return 0 }
        return tableView.bounds.height / CGFloat(count)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petMenuTitles?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: cellID,
            for: indexPath
        ) as? PetInfoTableCell else { return UITableViewCell() }
        cell.configureTitle(petMenuTitles?[indexPath.row])
        cell.configurePlaceholder(nil)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentControllerCallBack?()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Public Methods
extension PetInfoCell {
    public func configureCell(_ data: Any?) {
        guard let model = data as? PetInfoModel else { return }
        petMenuTitles = model.uploadInfo()
    }
}
