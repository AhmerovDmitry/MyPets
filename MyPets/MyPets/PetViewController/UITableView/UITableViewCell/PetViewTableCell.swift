//
//  PetViewTableCell.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 28.10.2020.
//

import UIKit

class PetViewTableCell: UITableViewCell, GeneralSetupProtocol {
    var tableCellLable = UILabel()
    let tableCellPlaceholder = UILabel()
    
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
        contentView.addSubview(tableCellPlaceholder)
        
        tableCellLable.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                             constant: 15).isActive = true
        tableCellLable.rightAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        tableCellLable.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        tableCellPlaceholder.leftAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        tableCellPlaceholder.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                                    constant: -15).isActive = true
        tableCellPlaceholder.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    func setupViewsAndLabels() {
        tableCellLable.translatesAutoresizingMaskIntoConstraints = false
        tableCellLable.textAlignment = .left
        tableCellLable.textColor = UIColor.CustomColor.dark
        tableCellLable.font = UIFont.systemFont(ofSize: 15)
        tableCellLable.adjustsFontSizeToFitWidth = true
        
        tableCellPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        tableCellPlaceholder.textAlignment = .right
        tableCellPlaceholder.textColor = UIColor.CustomColor.gray
        tableCellPlaceholder.font = UIFont.systemFont(ofSize: 15)
        tableCellPlaceholder.adjustsFontSizeToFitWidth = true
        
    }
    
    func presentController() {}
}
