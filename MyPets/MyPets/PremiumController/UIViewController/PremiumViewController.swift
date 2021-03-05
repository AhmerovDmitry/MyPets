//
//  PremiumViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 12.10.2020.
//

import UIKit

class PremiumViewController: UIViewController {
    let models = [
        "Неограниченное количество питомцев",
        "Календарь прививок, лечение и профилактика болезней",
        "Заболевания, назначения врача",
        "Все документы питомца в одном месте",
        "Рекомендации по уходу и питанию"
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
        tv.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
        
        return tv
    }()
    private let priceLabel = UILabel()
    private let priceDescLabel = UILabel()
    private let buyButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupConstraints()
        setupElements()
        
        let colorOne = UIColor(red: 137/255, green: 46/255, blue: 223/255, alpha: 1)
        let colorTwo = UIColor(red: 212/255, green: 165/255, blue: 255/255, alpha: 1)
        view.gradientSetup(view: view, colorOne: colorOne, colorTwo: colorTwo)
    }
    
}

extension PremiumViewController: GeneralSetupProtocol {
    //MARK: - Setup Constraints
    func setupConstraints() {
        [mainStackView,
         closeButton].forEach({ view.addSubview($0) })
        [titleLogo,
         titleText].forEach({ titleStackView.addArrangedSubview($0) })
        [titleStackView,
         tableView,
         priceLabel,
         priceDescLabel,
         buyButton].forEach({
            mainStackView.addArrangedSubview($0)
         })
        
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 14),
            closeButton.heightAnchor.constraint(equalToConstant: 14),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor,
                                             constant: UIApplication.shared.statusBarFrame.height + 15),
            closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            
            mainStackView.widthAnchor.constraint(equalToConstant: view.bounds.width / 1.2),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -17.5),
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.leftAnchor.constraint(equalTo: mainStackView.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: mainStackView.rightAnchor),
            tableView.heightAnchor.constraint(equalToConstant: view.bounds.height / 3),
            
            buyButton.leftAnchor.constraint(equalTo: mainStackView.leftAnchor),
            buyButton.rightAnchor.constraint(equalTo: mainStackView.rightAnchor)
        ])
        
        buyButton.addConstraint(NSLayoutConstraint(item: buyButton,
                                                   attribute: .width,
                                                   relatedBy: .equal,
                                                   toItem: buyButton,
                                                   attribute: .height,
                                                   multiplier: 6.22,
                                                   constant: 0))
    }
    
    func setupElements() {
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
        
        [titleText,
         priceLabel,
         priceDescLabel,
         buyButton.titleLabel].forEach({ $0?.adjustsFontSizeToFitWidth = true })
        
        mainStackView.alignment = .center
        mainStackView.axis = .vertical
        mainStackView.spacing = 32
        mainStackView.setCustomSpacing(24, after: titleStackView)
        mainStackView.setCustomSpacing(4, after: priceLabel)
        
        titleStackView.alignment = .center
        titleStackView.axis = .horizontal
        titleStackView.spacing = 10
        
        closeButton.setImage(UIImage(named: "closeButton"), for: .normal)
        closeButton.contentHorizontalAlignment = .fill
        closeButton.contentVerticalAlignment = .fill
        closeButton.addTarget(self, action: #selector(closeController), for: .touchUpInside)
        
        titleLogo.image = UIImage(named: "crownIcon")
        
        titleText.text = "MyPets Premium"
        titleText.textColor = .white
        titleText.textAlignment = .center
        titleText.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        
        priceLabel.text = "149 ₽"
        priceLabel.textColor = .white
        priceLabel.textAlignment = .center
        priceLabel.font = UIFont.systemFont(ofSize: 48, weight: .semibold)
        
        priceDescLabel.text = "Навсегда и без ограничений"
        priceDescLabel.textColor = .white
        priceDescLabel.textAlignment = .center
        priceDescLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        buyButton.layoutIfNeeded()
        buyButton.setTitle("Получить Premium", for: .normal)
        buyButton.backgroundColor = .white
        buyButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        buyButton.setTitleColor(UIColor.CustomColor.purple, for: .normal)
        buyButton.titleLabel?.adjustsFontSizeToFitWidth = true
        buyButton.layer.cornerRadius = buyButton.frame.height / 2
        buyButton.addTarget(self, action: #selector(presentController), for: .touchUpInside)
    }
    
    func setupNavigationController() {}
}
