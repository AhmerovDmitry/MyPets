//
//  OnboardViewCell.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 11.10.2020.
//

import UIKit

class OnboardViewCell: UICollectionViewCell {
    var model: OnboardModel? {
        didSet {
            guard let model = model else { return }
            imageView.image = UIImage(named: model.image)
            textLabel.text = model.text
        }
    }
    private let mainStackView = UIStackView()
    private let imageView = UIImageView()
    private let textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnboardViewCell: GeneralSetupProtocol {
    func setup() {
        setupConstraints()
        setupElements()
    }
    
    func setupConstraints() {
        contentView.addSubview(mainStackView)
        [imageView,
         textLabel].forEach({ mainStackView.addArrangedSubview($0) })
        
        mainStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor,
                                               constant: -77.5).isActive = true
        mainStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        mainStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        imageView.heightAnchor.constraint(lessThanOrEqualToConstant: 254).isActive = true
        imageView.widthAnchor.constraint(lessThanOrEqualToConstant: 381).isActive = true
        imageView.addConstraint(NSLayoutConstraint(item: imageView,
                                                   attribute: .width,
                                                   relatedBy: .equal,
                                                   toItem: imageView,
                                                   attribute: .height,
                                                   multiplier: 1.5,
                                                   constant: 0))
        
        textLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 263).isActive = true
        textLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 47).isActive = true
        textLabel.addConstraint(NSLayoutConstraint(item: textLabel,
                                                   attribute: .width,
                                                   relatedBy: .equal,
                                                   toItem: textLabel,
                                                   attribute: .height,
                                                   multiplier: 5.5,
                                                   constant: 0))
    }
    
    func setupElements() {
        [mainStackView,
         imageView,
         textLabel].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
         })
        
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.spacing = 16
        
        imageView.contentMode = .scaleAspectFit
        
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        textLabel.textColor = UIColor.CustomColor.dark
        textLabel.numberOfLines = 0
        textLabel.adjustsFontSizeToFitWidth = true
    }
    
    func presentController() {
    }
}
