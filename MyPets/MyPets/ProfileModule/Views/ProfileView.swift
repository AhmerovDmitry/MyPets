//
//  ProfileView.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 12.09.2021.
//

import UIKit

final class ProfileView: UIView {
    private var profileTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
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

extension ProfileView {
    private func setupUI() {
        setProfileTableViewConstraints()
    }
    private func setProfileTableViewConstraints() {
        self.addSubview(profileTableView)
        profileTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(equalTo: self.topAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            profileTableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            profileTableView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
}

extension ProfileView {
    func tableViewDelegateAndDataSource<T>(_ target: T) where T: UITableViewDelegate, T: UITableViewDataSource {
        profileTableView.delegate = target
        profileTableView.dataSource = target
    }
    func setTableViewID(_ id: String) {
        profileTableView.register(UITableViewCell.self, forCellReuseIdentifier: id)
    }
}
