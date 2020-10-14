//
//  PremiumViewControllerCell.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 12.10.2020.
//

import UIKit

class PremiumViewControllerCell: UITableViewCell {
    var model: PremiumModel? {
        didSet {
            guard let model = model else { return }
            premiumText.text = model.text
        }
    }
    let premiumText = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PremiumViewControllerCell: MainViewProtocol {
    func setup() {
        setupConstraint()
        setupViewsAndLabels()
    }
    
    func setupConstraint() {
        contentView.addSubview(premiumText)
        
        premiumText.widthAnchor.constraint(lessThanOrEqualToConstant: 300).isActive = true
        premiumText.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        premiumText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 19).isActive = true
        premiumText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
    }
    
    func setupViewsAndLabels() {
        premiumText.translatesAutoresizingMaskIntoConstraints = false
        premiumText.textAlignment = .center
        premiumText.textColor = .white
        premiumText.numberOfLines = 0
        premiumText.font = UIFont.systemFont(ofSize: 15, weight: .light)
    }
    
    func presentController() {
    }
}
