//
//  MenuCell.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 05.03.2021.
//

import UIKit

class MenuCell: UICollectionViewCell, GeneralSetupProtocol {
    let titleImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    let menuTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor.CustomColor.dark
        
        return label
    }()
    let descLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor.CustomColor.dark.withAlphaComponent(0.8)
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
        setupElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        self.addSubview(titleImage)
        self.addSubview(containerView)
        containerView.addSubview(menuTitleLabel)
        containerView.addSubview(descLabel)
        
        NSLayoutConstraint.activate([
            titleImage.heightAnchor.constraint(equalToConstant: self.bounds.height / 2),
            titleImage.widthAnchor.constraint(equalTo: titleImage.heightAnchor),
            titleImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleImage.leftAnchor.constraint(equalTo: self.leftAnchor,
                                             constant: self.bounds.height / 6),
            
            containerView.heightAnchor.constraint(equalTo: titleImage.heightAnchor),
            containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            containerView.leftAnchor.constraint(equalTo: titleImage.rightAnchor,
                                                constant: self.bounds.height / 6),
            containerView.rightAnchor.constraint(equalTo: self.rightAnchor,
                                               constant: -self.bounds.height / 6),
            
            menuTitleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            menuTitleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            menuTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            menuTitleLabel.heightAnchor.constraint(equalToConstant: self.bounds.height / 4),
            
            descLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            descLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            descLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            descLabel.heightAnchor.constraint(equalToConstant: self.bounds.height / 4)
        ])
    }
    
    func setupElements() {
        let shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shadowColor = UIColor.CustomColor.dark.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.20
        self.layer.masksToBounds = false
        self.layer.shadowPath = shadowPath
        self.layer.shadowRadius = 7
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
    }
    func setupNavigationController() {}
    func presentController() {}
}

