//
//  PetViewTableCell.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 28.10.2020.
//

import UIKit

class PetViewTableCell: UITableViewCell, GeneralSetupProtocol {
    let tableCellLable = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraint()
        setupViewsAndLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraint() {
        contentView.addSubview(tableCellLable)
        tableCellLable.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                         constant: 15).isActive = true
        tableCellLable.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        tableCellLable.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    func setupViewsAndLabels() {
        tableCellLable.translatesAutoresizingMaskIntoConstraints = false
        tableCellLable.backgroundColor = .white
        tableCellLable.textColor = UIColor.CustomColor.dark
        tableCellLable.font = UIFont.systemFont(ofSize: 15)
    }
    
    func presentController() {}
    
}
