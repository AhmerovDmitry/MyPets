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
    public var presentControllerCallBack: ((Int) -> Void)?
    private var petMenuModel = PetInfoModel()
    private let cellID = "petTableCell"
    private let petNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.CustomColor.dark
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    private lazy var petInfoTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.isScrollEnabled = false
        tableView.register(PetInfoTableCell.self, forCellReuseIdentifier: cellID)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
        tableView.delegate = self
        tableView.dataSource = self
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
            petInfoTable.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            petInfoTable.leftAnchor.constraint(equalTo: self.leftAnchor),
            petInfoTable.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
}

// MARK: - Delegate & DataSource
extension PetInfoCell: UITableViewDelegate, UITableViewDataSource {
    public func tableViewDelegate<T: UITableViewDelegate>(_ target: T) {
        petInfoTable.delegate = target
    }
    public func tableViewDataSource<T: UITableViewDataSource>(_ target: T) {
        petInfoTable.dataSource = target
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let count = petMenuModel.menuTitles.count
        return tableView.bounds.height / CGFloat(count)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petMenuModel.menuTitles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: cellID,
            for: indexPath
        ) as? PetInfoTableCell else { return UITableViewCell() }
        cell.configureTitle(petMenuModel.menuTitles[indexPath.row])
        cell.configurePlaceholder(petMenuModel.petInformation[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentControllerCallBack?(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Public Methods
extension PetInfoCell {
    public func configureCell(_ data: Any?) {
        guard let model = data as? PetInfoModel else { return }
        petMenuModel = model
        petNameLabel.text = model.petInformation[0] ?? ""
        petInfoTable.reloadData()
    }
}
