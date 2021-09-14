//
//  EntitysProfileView.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 13.09.2021.
//

import UIKit

final class EntitysView: UIView {
    private var entitysTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView()
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EntitysView {
    private func setupUI() {
        setChildrenProfileTableViewConstraints()
    }
    private func setChildrenProfileTableViewConstraints() {
        self.addSubview(entitysTableView)
        entitysTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            entitysTableView.topAnchor.constraint(equalTo: self.topAnchor),
            entitysTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            entitysTableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            entitysTableView.rightAnchor.constraint(equalTo: self.rightAnchor),
        ])
    }
}

extension EntitysView {
    func tableViewDelegateAndDataSource<T>(_ target: T) where T: UITableViewDelegate, T: UITableViewDataSource {
        entitysTableView.delegate = target
        entitysTableView.dataSource = target
    }
    func setTableViewID(_ id: String) {
        entitysTableView.register(UITableViewCell.self, forCellReuseIdentifier: id)
    }
}
