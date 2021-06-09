//
//  ProfileViewCell.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 09.01.2021.
//

import UIKit

class ProfileViewCell: UITableViewCell {
    let userImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        
        return img
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.CustomColor.dark
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.CustomColor.gray
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.text = "Мои данные"
        
        return label
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        userImageView.layer.cornerRadius = userImageView.bounds.height / 2
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if style == .subtitle {
            self.addSubview(userImageView)
            self.addSubview(containerView)
            containerView.addSubview(nameLabel)
            containerView.addSubview(descLabel)
            
            NSLayoutConstraint.activate([
                userImageView.heightAnchor.constraint(equalToConstant: self.bounds.height - 10),
                userImageView.widthAnchor.constraint(equalTo: userImageView.heightAnchor),
                userImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                userImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
                
                containerView.heightAnchor.constraint(equalToConstant: self.bounds.height - 10),
                containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                containerView.leftAnchor.constraint(equalTo: userImageView.rightAnchor, constant: 15),
                containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
                
                nameLabel.heightAnchor.constraint(equalToConstant: (self.bounds.height - 10) / 2),
                nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
                nameLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor),
                nameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor),
                
                descLabel.heightAnchor.constraint(equalToConstant: (self.bounds.height - 10) / 2),
                descLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                descLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor),
                descLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            ])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
