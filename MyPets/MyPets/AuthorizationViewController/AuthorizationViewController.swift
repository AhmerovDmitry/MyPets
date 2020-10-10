//
//  ViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 09.10.2020.
//

import UIKit

class AuthorizationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

<<<<<<< Updated upstream
=======
extension AuthorizationViewController: AuthorizationViewControllerProtocol {
    func setup() {
        setupConstraint()
        setupViewsAndLabels()
    }
    
    func setupConstraint() {
        //MARK: - Logo Constraints
        view.addSubview(logoStackView)
        logoStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 202).isActive = true
        logoStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        [logoLabel, textLabel].forEach({ logoStackView.addArrangedSubview($0) })
        
        logoLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        logoLabel.heightAnchor.constraint(equalToConstant: 124).isActive = true
        
        textLabel.widthAnchor.constraint(equalToConstant: 141).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 39).isActive = true
        
        //MARK: - Authorization Constraints
        view.addSubview(authorizationStackView)
        authorizationStackView.topAnchor.constraint(equalTo: logoStackView.bottomAnchor, constant: 22).isActive = true
        authorizationStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        [signInButton, logInButton].forEach({ authorizationStackView.addArrangedSubview($0) })
        
        signInButton.widthAnchor.constraint(equalToConstant: 311).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        logInButton.widthAnchor.constraint(equalToConstant: 311).isActive = true
        logInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //MARK: - Social Networks Constraints
        view.addSubview(textLine)
        view.addSubview(socialNetworksLabel)
        textLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        textLine.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textLine.topAnchor.constraint(equalTo: authorizationStackView.bottomAnchor, constant: 74).isActive = true
        textLine.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        textLine.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        
        socialNetworksLabel.widthAnchor.constraint(equalToConstant: 213).isActive = true
        socialNetworksLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        socialNetworksLabel.centerXAnchor.constraint(equalTo: textLine.centerXAnchor).isActive = true
        socialNetworksLabel.centerYAnchor.constraint(equalTo: textLine.centerYAnchor).isActive = true
        
        //MARK: - Social Icons Constraints
        view.addSubview(socialIconsStackView)
        socialIconsStackView.topAnchor.constraint(equalTo: socialNetworksLabel.bottomAnchor, constant: 16).isActive = true
        socialIconsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        [facebookButton, okButton, vkButton].forEach({ icon in
            socialIconsStackView.addArrangedSubview(icon)
            
            icon.widthAnchor.constraint(equalToConstant: 44).isActive = true
            icon.heightAnchor.constraint(equalToConstant: 44).isActive = true
        })
    }
    
    func setupViewsAndLabels() {
        [logoStackView, logoLabel, textLabel,
         authorizationStackView, logInButton, signInButton,
         socialNetworksLabel, textLine,
         socialIconsStackView, facebookButton, okButton, vkButton].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        
        //MARK: - Logo Settings
        logoStackView.alignment = .center
        logoStackView.spacing = 15
        logoStackView.axis = .vertical
        
        logoLabel.image = UIImage(named: "mainIcon")
        textLabel.image = UIImage(named: "myPetsText")
        
        //MARK: - Authorization Settings
        authorizationStackView.alignment = .center
        authorizationStackView.spacing = 16
        authorizationStackView.axis = .vertical
        
        signInButton.setTitle("Зарегистрироваться", for: .normal)
        signInButton.backgroundColor = UIColor.CustomColor.purple
        signInButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.layer.cornerRadius = 25
        
        logInButton.setTitle("Войти", for: .normal)
        logInButton.backgroundColor = .white
        logInButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        logInButton.setTitleColor(UIColor.CustomColor.purple, for: .normal)
        logInButton.layer.borderWidth = 1
        logInButton.layer.borderColor = UIColor.CustomColor.purple.cgColor
        logInButton.layer.cornerRadius = 25
        
        //MARK: - Social Networks Settings
        socialIconsStackView.alignment = .center
        socialIconsStackView.spacing = 16
        socialIconsStackView.axis = .horizontal
        
        textLine.backgroundColor = .black
        
        socialNetworksLabel.text = "Войти через социальные сети"
        socialNetworksLabel.font = UIFont.systemFont(ofSize: 14)
        socialNetworksLabel.textAlignment = .center
        socialNetworksLabel.backgroundColor = .white
        
        //MARK: - Social Networ Icon Settings
        facebookButton.setImage(UIImage(named: "facebookIcon"), for: .normal)
        okButton.setImage(UIImage(named: "okIcon"), for: .normal)
        vkButton.setImage(UIImage(named: "vkIcon"), for: .normal)
        
        signInButton.addTarget(self, action: #selector(fetchData), for: .touchUpInside)
    }
    
}

@objc
extension AuthorizationViewController {
    func fetchData() {
        print("bounds - ", logoStackView.bounds)
        print("frame - ",logoStackView.frame)
    }
}
>>>>>>> Stashed changes
