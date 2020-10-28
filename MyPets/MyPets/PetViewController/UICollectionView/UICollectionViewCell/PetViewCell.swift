//
//  PetViewCell.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 28.10.2020.
//

import UIKit

class PetViewCell: UICollectionViewCell, GeneralSetupProtocol {
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraint()
        setupViewsAndLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraint() {
        contentView.addSubview(label)
        label.topAnchor.constraint(equalTo: contentView.topAnchor,
                                   constant: 15).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                      constant: -15).isActive = true
        label.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                    constant: 15).isActive = true
        label.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                     constant: -15).isActive = true
    }
    
    func setupViewsAndLabels() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
    }
    
    func presentController() {}
}
