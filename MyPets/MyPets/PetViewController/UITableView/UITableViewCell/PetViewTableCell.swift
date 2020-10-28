//
//  PetViewTableCell.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 28.10.2020.
//

import UIKit

class PetViewTableCell: UITableViewCell, GeneralSetupProtocol {
    let labelTable = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraint()
        setupViewsAndLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraint() {
        contentView.addSubview(labelTable)
        labelTable.topAnchor.constraint(equalTo: contentView.topAnchor,
                                   constant: 0).isActive = true
        labelTable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                      constant: 0).isActive = true
        labelTable.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                    constant: 0).isActive = true
        labelTable.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                     constant: 0).isActive = true
    }
    
    func setupViewsAndLabels() {
        labelTable.translatesAutoresizingMaskIntoConstraints = false
        labelTable.backgroundColor = .yellow
    }
    
    func presentController() {}
    
}
