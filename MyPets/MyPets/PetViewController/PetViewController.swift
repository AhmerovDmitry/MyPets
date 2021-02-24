//
//  PetViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 15.10.2020.
//

import UIKit

class PetViewController: UIViewController, GeneralSetupProtocol {
    lazy var petEntitys = [PetModel]()
    private let mainStackView = UIStackView()
    private let mainImage = UIImageView()
    private let titleText = UILabel()
    private let descText = UILabel()
    private let addButton = UIButton(type: .system)
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(EntityCell.self, forCellWithReuseIdentifier: "entityCell")
        cv.isHidden = true
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupNavigationController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupConstraints()
        setupElements()
        
        if !petEntitys.isEmpty {
            mainStackView.isHidden = true
            collectionView.isHidden = false
            let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(presentController))
            navigationItem.rightBarButtonItem = addButton
            navigationItem.rightBarButtonItem?.tintColor = UIColor.CustomColor.purple
        }
    }
    
    func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.CustomColor.dark]
        navigationItem.title = "Питомцы"
    }
    
    func setupConstraints() {
        view.addSubview(collectionView)
        view.addSubview(mainStackView)
        [mainImage,
         titleText,
         descText,
         addButton].forEach { mainStackView.addArrangedSubview($0) }
        
        mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor,
                                               constant: -10).isActive = true
        mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        mainImage.leftAnchor.constraint(equalTo: mainStackView.leftAnchor,
                                        constant: 0).isActive = true
        mainImage.rightAnchor.constraint(equalTo: mainStackView.rightAnchor,
                                         constant: 0).isActive = true
        
        titleText.leftAnchor.constraint(equalTo: mainStackView.leftAnchor,
                                        constant: 32).isActive = true
        titleText.rightAnchor.constraint(equalTo: mainStackView.rightAnchor,
                                         constant: -32).isActive = true
        titleText.addConstraint(NSLayoutConstraint(item: titleText,
                                                   attribute: .width,
                                                   relatedBy: .equal,
                                                   toItem: titleText,
                                                   attribute: .height,
                                                   multiplier: 7.6,
                                                   constant: 0))
        
        descText.leftAnchor.constraint(equalTo: mainStackView.leftAnchor,
                                       constant: 32).isActive = true
        descText.rightAnchor.constraint(equalTo: mainStackView.rightAnchor,
                                        constant: -32).isActive = true
        descText.addConstraint(NSLayoutConstraint(item: descText,
                                                  attribute: .width,
                                                  relatedBy: .equal,
                                                  toItem: descText,
                                                  attribute: .height,
                                                  multiplier: 6,
                                                  constant: 0))
        
        
        addButton.leftAnchor.constraint(equalTo: mainStackView.leftAnchor,
                                        constant: 32).isActive = true
        addButton.rightAnchor.constraint(equalTo: mainStackView.rightAnchor,
                                         constant: -32).isActive = true
        addButton.addConstraint(NSLayoutConstraint(item: addButton,
                                                   attribute: .width,
                                                   relatedBy: .equal,
                                                   toItem: addButton,
                                                   attribute: .height,
                                                   multiplier: 6,
                                                   constant: 0))
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    func setupElements() {
        [mainStackView,
         mainImage,
         titleText,
         descText,
         addButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
         }
        
        mainStackView.alignment = .center
        mainStackView.axis = .vertical
        mainStackView.spacing = 4
        mainStackView.setCustomSpacing(8, after: titleText)
        mainStackView.setCustomSpacing(16, after: descText)
        
        mainImage.image = UIImage(named: "IconPet")
        mainImage.contentMode = .scaleAspectFit
        
        titleText.text = "Добавьте питомца"
        titleText.textAlignment = .center
        titleText.font = UIFont.boldSystemFont(ofSize: 16)
        titleText.textColor = UIColor.CustomColor.dark
        titleText.numberOfLines = 0
        titleText.adjustsFontSizeToFitWidth = true
        
        descText.text = "Все данные вашего питомца будут всегда под рукой"
        descText.textAlignment = .center
        descText.font = UIFont.systemFont(ofSize: 14)
        descText.textColor = UIColor.CustomColor.dark
        descText.numberOfLines = 0
        descText.adjustsFontSizeToFitWidth = true
        
        addButton.layoutIfNeeded()
        addButton.backgroundColor = UIColor.CustomColor.purple
        addButton.setTitle("Добавить питомца", for: .normal)
        addButton.tintColor = .white
        addButton.layer.cornerRadius = addButton.frame.height / 2
        addButton.titleLabel?.adjustsFontSizeToFitWidth = true
        addButton.addTarget(self, action: #selector(presentController), for: .touchUpInside)
    }
}

extension PetViewController: EntityTransfer {
    func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    func entityTransfer(_ entity: PetModel) {
        petEntitys.append(entity)
    }
    
    func reloadController() {
        self.viewDidLoad()
    }
}
