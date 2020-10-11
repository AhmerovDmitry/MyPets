//
//  OnboardViewCell.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 11.10.2020.
//

import UIKit

class OnboardViewCell: UICollectionViewCell {
    private let mainStackView = UIStackView()
    private let imageView = UIImageView()
    private let textLabel = UILabel()
    private let pageControl = UIPageControl()
    private let doneButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .purple
        setup()
        
        imageView.image = UIImage(named: "onboardImage_1")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnboardViewCell: OnboardViewControllerProtocol {
    func setup() {
        setupConstraint()
        setupViewsAndLabels()
    }
    
    func setupConstraint() {
        contentView.addSubview(mainStackView)
        [imageView, textLabel, pageControl, doneButton].forEach({ mainStackView.addArrangedSubview($0) })

        mainStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -49).isActive = true
        mainStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        imageView.widthAnchor.constraint(equalToConstant: 375).isActive = true
        imageView.heightAnchor.constraint(lessThanOrEqualToConstant: 282).isActive = true

        textLabel.widthAnchor.constraint(equalToConstant: 263).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 47).isActive = true

        pageControl.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 8).isActive = true

        doneButton.widthAnchor.constraint(equalToConstant: 311).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupViewsAndLabels() {
        [mainStackView, imageView, textLabel, pageControl, doneButton].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.spacing = 16
        mainStackView.setCustomSpacing(32, after: pageControl)
        
        imageView.contentMode = .scaleAspectFit
        
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 18)
        textLabel.textColor = .black
        textLabel.numberOfLines = 0
        textLabel.text = "Вся информация о питомце всегда под рукой"
        
        pageControl.currentPage = 0
        pageControl.numberOfPages = 4
        pageControl.currentPageIndicatorTintColor = UIColor.CustomColor.purple
        pageControl.pageIndicatorTintColor = UIColor.CustomColor.lightGray
        
        doneButton.setTitle("Далее", for: .normal)
        doneButton.backgroundColor = .white
        doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        doneButton.setTitleColor(UIColor.CustomColor.purple, for: .normal)
        doneButton.layer.borderWidth = 1
        doneButton.layer.borderColor = UIColor.CustomColor.purple.cgColor
        doneButton.layer.cornerRadius = 25
    }
}
