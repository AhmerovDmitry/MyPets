//
//  PetViewCollectionCell.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 28.10.2020.
//

import UIKit

class PetViewCollectionCell: UICollectionViewCell, GeneralSetupProtocol {
    let label = UILabel()
    let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.isScrollEnabled = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(PremiumViewControllerCell.self, forCellReuseIdentifier: "tableCellPetId")
        
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraint()
        setupViewsAndLabels()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraint() {
        contentView.addSubview(label)
        contentView.addSubview(tableView)
        label.topAnchor.constraint(equalTo: contentView.topAnchor,
                                   constant: 15).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                      constant: -15).isActive = true
        label.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                    constant: 15).isActive = true
        label.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                     constant: -15).isActive = true
        
        tableView.topAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func setupViewsAndLabels() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
    }
    
    func presentController() {}
}
