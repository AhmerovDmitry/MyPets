//
//  PremiumViewControllerCell.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 12.10.2020.
//

import UIKit

class PremiumViewControllerCell: UITableViewCell {
    
    var model: String? {
        didSet {
            guard let model = model else { return }
            premiumText.text = model
        }
    }
    let premiumText = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        setupElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PremiumViewControllerCell: GeneralSetupProtocol {
    func setupConstraints() {
        contentView.addSubview(premiumText)
        
        premiumText.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                          constant: 10).isActive = true
        premiumText.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                           constant: -10).isActive = true
        premiumText.topAnchor.constraint(equalTo: contentView.topAnchor,
                                         constant: 10).isActive = true
        premiumText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                            constant: -10).isActive = true
    }
    
    func setupElements() {
        premiumText.translatesAutoresizingMaskIntoConstraints = false
        premiumText.textAlignment = .center
        premiumText.textColor = .white
        premiumText.numberOfLines = 0
        premiumText.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        premiumText.adjustsFontSizeToFitWidth = true
    }
    
    func setupNavigationController() {}
    func presentController() {}
    
}
