//
//  PremiumViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 12.10.2020.
//

import UIKit

class PremiumViewController: UIViewController {
    private let closeButton = UIButton(type: .custom)
    private let strockArray = [UILabel]()
    private let descriptionArray = [UILabel]()
    private let buyButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension PremiumViewController: OnboardViewControllerProtocol {
    func setup() {
        setupConstraint()
        setupViewsAndLabels()
        gradientSetup()
    }
    
    func setupConstraint() {
        view.addSubview(closeButton)
        
        closeButton.widthAnchor.constraint(lessThanOrEqualToConstant: 14).isActive = true
        closeButton.heightAnchor.constraint(lessThanOrEqualToConstant: 14).isActive = true
        closeButton.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: 61).isActive = true
        closeButton.rightAnchor.constraint(lessThanOrEqualTo: view.rightAnchor, constant: -15).isActive = true
    }
    
    func setupViewsAndLabels() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setImage(UIImage(named: "closeButton"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeController), for: .touchUpInside)
    }
    
    func gradientSetup() {
        let colorOne = UIColor(red: 137/255, green: 46/255, blue: 223/255, alpha: 1)
        let colorTwo = UIColor(red: 212/255, green: 165/255, blue: 255/255, alpha: 1)
        view.setGradientBackground(colorOne: colorOne, ColorTwo: colorTwo, startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1))
    }
    
    @objc func closeController() {
        let authorizationVC = AuthorizationViewController()
        authorizationVC.modalPresentationStyle = .fullScreen
        present(authorizationVC, animated: true, completion: nil)
    }
    
    func presentController() {
    }
}
