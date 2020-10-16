//
//  PetViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 15.10.2020.
//

import UIKit

class PetViewController: UIViewController, GeneralSetupProtocol {
    private let mainStackView = UIStackView()
    private let mainImage = UIImageView()
    private let titleText = UILabel()
    private let descText = UILabel()
    private let addButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.title = "Питомцы"
        
        view.backgroundColor = .white
        setup()
    }
    
    func setup() {
        setupConstraint()
        setupViewsAndLabels()
    }
    
    func setupConstraint() {
        view.addSubview(mainStackView)
        
        mainStackView.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: 150).isActive = true
        mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        [mainImage,
         titleText,
         descText,
         addButton].forEach({ mainStackView.addArrangedSubview($0) })
        
        mainImage.widthAnchor.constraint(lessThanOrEqualToConstant: 381).isActive = true
        mainImage.heightAnchor.constraint(lessThanOrEqualToConstant: 254).isActive = true
        
        titleText.widthAnchor.constraint(lessThanOrEqualToConstant: 152).isActive = true
        titleText.heightAnchor.constraint(lessThanOrEqualToConstant: 20).isActive = true
        
        descText.widthAnchor.constraint(lessThanOrEqualToConstant: 311).isActive = true
        descText.heightAnchor.constraint(lessThanOrEqualToConstant: 36).isActive = true
        
        addButton.widthAnchor.constraint(lessThanOrEqualToConstant: 311).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupViewsAndLabels() {
        [mainStackView,
         mainImage,
         titleText,
         descText,
         addButton].forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        
        mainStackView.alignment = .center
        mainStackView.axis = .vertical
        mainStackView.spacing = 4
        mainStackView.setCustomSpacing(8, after: titleText)
        mainStackView.setCustomSpacing(16, after: descText)
        
        mainImage.image = UIImage(named: "onboardImage_1")
        
        titleText.text = "Добавьте питомца"
        titleText.textAlignment = .center
        titleText.font = UIFont.boldSystemFont(ofSize: 16)
        titleText.adjustsFontSizeToFitWidth = true
        
        descText.text = "Все данные вашего питомца будут всегда под рукой"
        descText.textAlignment = .center
        descText.font = UIFont.systemFont(ofSize: 14)
        descText.numberOfLines = 0
        descText.adjustsFontSizeToFitWidth = true
        
        addButton.backgroundColor = UIColor.CustomColor.purple
        addButton.setTitle("Добавить питомца", for: .normal)
        addButton.tintColor = .white
        addButton.layer.cornerRadius = 25
        addButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func presentController() {
    }
}
