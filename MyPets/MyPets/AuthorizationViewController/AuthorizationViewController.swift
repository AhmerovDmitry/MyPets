//
//  AuthorizationViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 09.10.2020.
//

import UIKit

class AuthorizationViewController: UIViewController {
    private let mainStackView = UIStackView()
    private let logoLabel = UIImageView()
    private let textLabel = UIImageView()
    
    private let logInButton = UIButton(type: .system)
    
    private var socialNetworkStackView = UIStackView()
    private let socialNetworksLabel = UILabel()
    private let leftTextLine = UILabel()
    private let rightTextLine = UILabel()
    
    private let socialIconsStackView = UIStackView()
    private let facebookButton = UIButton(type: .custom)
    private let okButton = UIButton(type: .custom)
    private let vkButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }
}

extension AuthorizationViewController: GeneralSetupProtocol {
    func setup() {
        setupConstraint()
        setupViewsAndLabels()
    }
    
    func setupConstraint() {
        //MARK: - Logo Constraints
        view.addSubview(mainStackView)
        
        mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor,
                                               constant: -1.5).isActive = true
        mainStackView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mainStackView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        [logoLabel,
         textLabel,
         logInButton,
         socialNetworkStackView,
         socialIconsStackView].forEach({ mainStackView.addArrangedSubview($0) })
        
        [facebookButton,
         okButton,
         vkButton].forEach({ icon in
            socialIconsStackView.addArrangedSubview(icon)
            
            icon.widthAnchor.constraint(equalToConstant: 44).isActive = true
            icon.heightAnchor.constraint(equalToConstant: 44).isActive = true
         })
        
        [leftTextLine,
         socialNetworksLabel,
         rightTextLine].forEach({ socialNetworkStackView.addArrangedSubview($0) })
        
        logoLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        logoLabel.heightAnchor.constraint(equalToConstant: 124).isActive = true
        
        textLabel.widthAnchor.constraint(equalToConstant: 141).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 39).isActive = true
        
        logInButton.leftAnchor.constraint(equalTo: mainStackView.leftAnchor,
                                          constant: 32).isActive = true
        logInButton.rightAnchor.constraint(equalTo: mainStackView.rightAnchor,
                                           constant: -32).isActive = true
        logInButton.addConstraint(NSLayoutConstraint(item: logInButton,
                                                     attribute: .width,
                                                     relatedBy: .equal,
                                                     toItem: logInButton,
                                                     attribute: .height,
                                                     multiplier: 6,
                                                     constant: 0))
        
        socialNetworksLabel.centerXAnchor.constraint(equalTo: socialNetworkStackView.centerXAnchor).isActive = true
        leftTextLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        leftTextLine.leftAnchor.constraint(equalTo: mainStackView.leftAnchor,
                                           constant: 16).isActive = true
        rightTextLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        rightTextLine.rightAnchor.constraint(equalTo: mainStackView.rightAnchor,
                                             constant: -16).isActive = true
    }
    
    func setupViewsAndLabels() {
        [mainStackView,
         logoLabel,
         textLabel,
         logInButton,
         socialNetworksLabel,
         leftTextLine,
         rightTextLine,
         socialIconsStackView,
         facebookButton,
         okButton,
         vkButton].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
         })
        //MARK: - Main UIStackView Settings
        mainStackView.alignment = .center
        mainStackView.spacing = 15
        mainStackView.axis = .vertical
        mainStackView.setCustomSpacing(22, after: textLabel)
        mainStackView.setCustomSpacing(77, after: logInButton)
        
        //MARK: - Logo Settings
        logoLabel.image = UIImage(named: "mainIcon")
        textLabel.image = UIImage(named: "myPetsText")
        
        //MARK: - Authorization Settings
        logInButton.layoutIfNeeded()
        logInButton.setTitle("Войти", for: .normal)
        logInButton.backgroundColor = UIColor.CustomColor.purple
        logInButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.titleLabel?.adjustsFontSizeToFitWidth = true
        logInButton.layer.cornerRadius = logInButton.frame.height / 2
        
        //MARK: - Social Networks Settings
        socialNetworkStackView.alignment = .center
        socialNetworkStackView.axis = .horizontal
        socialNetworkStackView.spacing = 6
        leftTextLine.backgroundColor = UIColor.CustomColor.lightGray
        rightTextLine.backgroundColor = UIColor.CustomColor.lightGray
        socialNetworksLabel.text = "Войти через социальные сети"
        socialNetworksLabel.font = UIFont.systemFont(ofSize: 14)
        socialNetworksLabel.textAlignment = .center
        socialNetworksLabel.backgroundColor = .white
        socialNetworksLabel.textColor = .black
        socialNetworksLabel.adjustsFontSizeToFitWidth = true
        
        //MARK: - Social UIStackView Settings
        socialIconsStackView.alignment = .center
        socialIconsStackView.spacing = 16
        socialIconsStackView.axis = .horizontal
        
        //MARK: - Social Networ Icon Settings
        facebookButton.setImage(UIImage(named: "facebookIcon"), for: .normal)
        okButton.setImage(UIImage(named: "okIcon"), for: .normal)
        vkButton.setImage(UIImage(named: "vkIcon"), for: .normal)
        
        logInButton.addTarget(self, action: #selector(presentController), for: .touchUpInside)
    }
}
