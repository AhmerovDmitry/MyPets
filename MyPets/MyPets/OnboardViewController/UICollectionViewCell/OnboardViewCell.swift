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
        setupConstraint()
        setupViewsAndLabels()
        
        imageView.image = UIImage(named: "onboardImage_1")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnboardViewCell: GeneralSetupProtocol {
    func setupConstraint() {
        contentView.addSubview(mainStackView)
        [imageView,
         textLabel].forEach({ mainStackView.addArrangedSubview($0) })
        
        mainStackView.bottomAnchor.constraint(equalTo: contentView.centerYAnchor,
                                              constant: 89).isActive = true
        mainStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        imageView.leftAnchor.constraint(equalTo: mainStackView.leftAnchor,
                                        constant: 0).isActive = true
        imageView.rightAnchor.constraint(equalTo: mainStackView.rightAnchor,
                                         constant: 0).isActive = true
        
        textLabel.widthAnchor.constraint(equalToConstant: 263).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 47).isActive = true
    }
    
    func setupViewsAndLabels() {
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
        textLabel.font = UIFont.systemFont(ofSize: 18)
        textLabel.textColor = UIColor.CustomColor.dark
        textLabel.numberOfLines = 0
        textLabel.text = "Вся информация о питомце всегда под рукой"
        textLabel.adjustsFontSizeToFitWidth = true
    }
    
    func presentController() {
    }
}
