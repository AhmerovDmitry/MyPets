//
//  PremiumViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 12.10.2020.
//

import UIKit
import SwiftUI

class PremiumViewController: UIViewController {
    let models = [
        PremiumModel(text: "Неограниченное количество питомцев"),
        PremiumModel(text: "Календарь прививок, лечение и профилактика болезней"),
        PremiumModel(text: "Заболевания, назначения врача"),
        PremiumModel(text: "Все документы питомца в одном месте"),
        PremiumModel(text: "Рекомендации по уходу и питанию")
    ]
    private let mainStackView = UIStackView()
    private let closeButton = UIButton(type: .custom)
    private let titleStackView = UIStackView()
    private let titleLogo = UIImageView()
    private let titleText = UILabel()
    private let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.isScrollEnabled = false
        tv.register(PremiumViewControllerCell.self, forCellReuseIdentifier: "cellId")
        tv.backgroundColor = .clear
        tv.separatorColor = .white
        tv.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return tv
    }()
    private let priceLabel = UILabel()
    private let priceDescLabel = UILabel()
    private let buyButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension PremiumViewController: GeneralSetupProtocol {
    func setup() {
        setupConstraint()
        setupViewsAndLabels()
        gradientSetup()
    }
    
    func setupConstraint() {
        [mainStackView, closeButton].forEach({ view.addSubview($0) })
        [titleLogo, titleText].forEach({ titleStackView.addArrangedSubview($0) })
        [titleStackView, tableView, priceLabel, priceDescLabel, buyButton].forEach({
            mainStackView.addArrangedSubview($0)
        })
        
        //MARK: - closeButton
        closeButton.widthAnchor.constraint(equalToConstant: 14).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 14).isActive = true
        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 61).isActive = true
        closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        
        //MARK: - titleStackView + titleLogo, titleText
        titleStackView.leftAnchor.constraint(equalTo: mainStackView.leftAnchor, constant: 63).isActive = true
        titleStackView.rightAnchor.constraint(equalTo: mainStackView.rightAnchor, constant: -63).isActive = true
        
        titleLogo.widthAnchor.constraint(equalTo: titleText.heightAnchor).isActive = true
        titleLogo.heightAnchor.constraint(equalTo: titleText.heightAnchor).isActive = true
        
        titleText.widthAnchor.constraint(lessThanOrEqualToConstant: 210).isActive = true
        titleText.heightAnchor.constraint(lessThanOrEqualToConstant: 32).isActive = true
        
        //MARK: - mainStackView
        mainStackView.centerYAnchor.constraint(lessThanOrEqualTo: view.centerYAnchor, constant: -17.5).isActive = true
        mainStackView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mainStackView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        //MARK: - tableView
        tableView.topAnchor.constraint(lessThanOrEqualTo: titleStackView.bottomAnchor, constant: 16).isActive = true
        tableView.leftAnchor.constraint(equalTo: mainStackView.leftAnchor, constant: 32).isActive = true
        tableView.rightAnchor.constraint(equalTo: mainStackView.rightAnchor, constant: -32).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 260).isActive = true
        //tableView.heightAnchor.constraint(greaterThanOrEqualToConstant: 270).isActive = true
        //tableView.heightAnchor.constraint(lessThanOrEqualToConstant: 320).isActive = true
        tableView.backgroundColor = .lightGray
        
        //MARK: - Price Label
        priceLabel.topAnchor.constraint(lessThanOrEqualTo: tableView.bottomAnchor, constant: 16).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: mainStackView.leftAnchor, constant: 122).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: mainStackView.rightAnchor, constant: -122).isActive = true
        //priceLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 58).isActive = true
        
        //MARK: - Price description
        priceDescLabel.topAnchor.constraint(lessThanOrEqualTo: priceLabel.bottomAnchor, constant: 4).isActive = true
        priceDescLabel.leftAnchor.constraint(equalTo: mainStackView.leftAnchor, constant: 95).isActive = true
        priceDescLabel.rightAnchor.constraint(equalTo: mainStackView.rightAnchor, constant: -95).isActive = true
        //priceDescLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 18).isActive = true
        
        //MARK: - Buy Button
        buyButton.topAnchor.constraint(lessThanOrEqualTo: priceDescLabel.bottomAnchor, constant: 32).isActive = true
        buyButton.leftAnchor.constraint(equalTo: mainStackView.leftAnchor, constant: 32).isActive = true
        buyButton.rightAnchor.constraint(equalTo: mainStackView.rightAnchor, constant: -32).isActive = true
        buyButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupViewsAndLabels() {
        [mainStackView,
         closeButton,
         titleStackView,
         titleLogo,
         titleText,
         tableView,
         priceLabel,
         priceDescLabel,
         buyButton].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
         })
        
        titleText.adjustsFontSizeToFitWidth = true
        priceLabel.adjustsFontSizeToFitWidth = true
        priceDescLabel.adjustsFontSizeToFitWidth = true
        buyButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        mainStackView.alignment = .center
        mainStackView.axis = .vertical
        mainStackView.spacing = 16
        mainStackView.setCustomSpacing(4, after: priceLabel)
        mainStackView.setCustomSpacing(32, after: priceDescLabel)
        
        titleStackView.alignment = .center
        titleStackView.axis = .horizontal
        titleStackView.spacing = 10
        
        closeButton.setImage(UIImage(named: "closeButton"), for: .normal)
        closeButton.contentHorizontalAlignment = .fill
        closeButton.contentVerticalAlignment = .fill
        //closeButton.addTarget(self, action: #selector(closeController), for: .touchUpInside)
        
        titleLogo.image = UIImage(named: "crownIcon")
        
        titleText.text = "MyPets Premium"
        titleText.textColor = .white
        titleText.textAlignment = .center
        titleText.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        
        priceLabel.text = "149 ₽"
        priceLabel.textColor = .white
        priceLabel.textAlignment = .center
        priceLabel.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        
        priceDescLabel.text = "Навсегда и без ограничений"
        priceDescLabel.textColor = .white
        priceDescLabel.textAlignment = .center
        priceDescLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        
        buyButton.setTitle("Получить Premium", for: .normal)
        buyButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        buyButton.setTitleColor(UIColor.CustomColor.purple, for: .normal)
        buyButton.backgroundColor = .white
        buyButton.layer.cornerRadius = 25
        buyButton.addTarget(self, action: #selector(presentController), for: .touchUpInside)
    }
    
    func gradientSetup() {
        let colorOne = UIColor(red: 137/255, green: 46/255, blue: 223/255, alpha: 1)
        let colorTwo = UIColor(red: 212/255, green: 165/255, blue: 255/255, alpha: 1)
        view.setGradientBackground(colorOne: colorOne, ColorTwo: colorTwo, startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1))
    }
}

struct MyProvider: PreviewProvider {
    static var previews: some View {
        ContianerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContianerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some PremiumViewController {
            return PremiumViewController()
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
}
