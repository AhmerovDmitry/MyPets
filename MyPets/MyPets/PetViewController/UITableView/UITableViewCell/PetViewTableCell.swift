//
//  PetViewTableCell.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 28.10.2020.
//

import UIKit

class PetViewTableCell: UITableViewCell, GeneralSetupProtocol {
    var tableCellLabel = UILabel()
    let tableCellPlaceholder = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraints()
        setupElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        contentView.addSubview(tableCellLabel)
        contentView.addSubview(tableCellPlaceholder)
        
        tableCellLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                             constant: 15).isActive = true
        tableCellLabel.rightAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        tableCellLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        tableCellPlaceholder.leftAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        tableCellPlaceholder.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                                    constant: -15).isActive = true
        tableCellPlaceholder.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    func setupElements() {
        [tableCellLabel, tableCellPlaceholder].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        tableCellLabel.textAlignment = .left
        tableCellLabel.textColor = UIColor.CustomColor.dark
        tableCellLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        tableCellLabel.adjustsFontSizeToFitWidth = true
        
        tableCellPlaceholder.textAlignment = .right
        tableCellPlaceholder.textColor = UIColor.CustomColor.gray
        tableCellPlaceholder.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        tableCellPlaceholder.adjustsFontSizeToFitWidth = true
        
    }
    
    func presentController() {}
}
