//
//  PetViewCollectionCell.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 28.10.2020.
//

import UIKit

class PetViewCollectionCell: UICollectionViewCell, GeneralSetupProtocol {
    weak var delegate: PetViewControllerDelegate?
    var models = [
        PetTableViewModel(title: "Кличка", info: nil),
        PetTableViewModel(title: "Вид", info: nil),
        PetTableViewModel(title: "Порода", info: nil),
        PetTableViewModel(title: "Дата рождения", info: nil),
        PetTableViewModel(title: "Вес, кг", info: nil),
        PetTableViewModel(title: "Стерилизация", info: nil),
        PetTableViewModel(title: "Окрас", info: nil),
        PetTableViewModel(title: "Шерсть", info: nil),
        PetTableViewModel(title: "Номер чипа", info: nil)
    ]
    let label = UILabel()
    let titleLabel = UILabel()
    let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.isScrollEnabled = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(PetViewTableCell.self, forCellReuseIdentifier: "tableCellPetId")
        tv.backgroundColor = .white
        
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
        contentView.addSubview(titleLabel)
        
        label.topAnchor.constraint(equalTo: contentView.topAnchor,
                                   constant: 15).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                      constant: -15).isActive = true
        label.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                    constant: 15).isActive = true
        label.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                     constant: -15).isActive = true
        
        tableView.heightAnchor.constraint(lessThanOrEqualToConstant: 404).isActive = true
        tableView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                          constant: -20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                         constant: 15).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                          constant: -15).isActive = true
    }
    
    func setupViewsAndLabels() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.CustomColor.dark
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
    }
    
    func presentController() {}
}
