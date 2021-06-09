//
//  PetInfoViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 28.10.2020.
//

import UIKit

class PetInfoViewController: UIViewController {
    
    var showEditedButtons = false {
        didSet {
            if showEditedButtons {
                UIView.animate(withDuration: 0.5, animations: {
                    self.cameraButton.alpha = 1
                    self.editedButton.alpha = 1
                    self.deleteButton.alpha = 1
                    self.cameraButton.frame.origin = CGPoint(x: self.rightBarButtonFrame.origin.x,
                                                             y: self.rightBarButtonFrame.origin.y + self.rightBarButtonFrame.height * 1.25)
                    self.editedButton.frame.origin = CGPoint(x: self.rightBarButtonFrame.origin.x,
                                                             y: self.cameraButton.frame.origin.y + self.rightBarButtonFrame.height * 1.25)
                    self.deleteButton.frame.origin = CGPoint(x: self.rightBarButtonFrame.origin.x,
                                                             y: self.editedButton.frame.origin.y + self.rightBarButtonFrame.height * 1.25)
                })
            } else {
                UIView.animate(withDuration: 0.5, animations: {
                    [self.cameraButton, self.editedButton, self.deleteButton].forEach({
                        $0.frame.origin = CGPoint(x: self.rightBarButtonFrame.origin.x,
                                                  y: self.rightBarButtonFrame.origin.y)
                        
                        $0.alpha = 0
                    })
                })
            }
        }
    }
    var rightBarButtonFrame = CGRect()
    var rightBarButtonItem = UIBarButtonItem()
    var leftBarButtonItem = UIBarButtonItem()
    
    let nilEntity = PetModel()
    var petEntity = PetModel()
    
    weak var delegate: EntityTransfer?
    
    var collectionItemIndex: Int?
    let collectionModel = [
        CollectionModel(image: UIImage(),
                        title: String(),
                        description: String()),
        CollectionModel(image: UIImage(named: "healthIcon"),
                        title: "Здоровье",
                        description: "Календарь прививок, лечение"),
        CollectionModel(image: UIImage(named: "documentIcon"),
                        title: "Документы",
                        description: "Паспорт, метрика, родословная и т.д."),
        CollectionModel(image: UIImage(named: "foodIcon"),
                        title: "Питание",
                        description: "Особенности рациона, кормление"),
        CollectionModel(image: UIImage(named: "careIcon"),
                        title: "Уход",
                        description: "Купание, расчёсывание, грумминг и т.д."),
        CollectionModel(image: UIImage(named: "entertainmentIcon"),
                        title: "Развлечения",
                        description: "Игры и развлечения питомца"),
    ]
    var tableView = UITableView()
    var indexPath = IndexPath()
    var updateInfo: ((IndexPath) -> ())?
    
    let backgroundView = UIView()
    let picker = UIDatePicker()
    let saveDateButton = UIButton(type: .system)
    var petInfo: String?
    var titleImage = UIImageView()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(PetViewCollectionCell.self, forCellWithReuseIdentifier: "collectionCellPetId")
        
        return cv
    }()
    
    let popToRootButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.backgroundColor = UIColor.CustomColor.lightGray
        button.setFrame()
        button.layer.cornerRadius = button.frame.height / 2
        
        return button
    }()
    
    let cameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.addTarget(self, action: #selector(presentController), for: .touchUpInside)
        
        return button
    }()
    let editedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.addTarget(self, action: #selector(editPetInfo), for: .touchUpInside)
        
        return button
    }()
    let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.addTarget(self, action: #selector(deletePet), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationController()
        setupConstraints()
        setupElements()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        rightBarButtonFrame = fetchRightBarButtonFrame()
        setupEditButtons()
    }
<<<<<<< HEAD
=======
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if petEntity != nilEntity {
            if collectionItemIndex == nil {
                delegate?.createEntity(petEntity)
            } else {
                if MainPetViewController.shared.tappedDeleteButton {
                    delegate?.deleteEntity(at: collectionItemIndex!)
                } else {
                    delegate?.updateEntity(petEntity, at: collectionItemIndex!)
                }
            }
        }
        MainPetViewController.shared.tappedDeleteButton = false
        delegate?.reloadCollectionView()
        delegate?.reloadController()
    }
>>>>>>> parent of c7810e9 (Import Realm in Project!!!)
}

extension PetInfoViewController: GeneralSetupProtocol {
    func setupNavigationController() {
        let baseCameraButton: UIButton = {
            let button = UIButton(type: .system)
            button.setImage(UIImage(named: "cameraIcon"), for: .normal)
            button.addTarget(self, action: #selector(presentController), for: .touchUpInside)
            button.backgroundColor = UIColor.CustomColor.lightGray
            button.frame = popToRootButton.frame
            button.layer.cornerRadius = button.frame.height / 2

            return button
        }()
        let baseEditedButton: UIButton = {
            let button = UIButton(type: .system)
            button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
            button.addTarget(self, action: #selector(showEditButtons), for: .touchUpInside)
            button.backgroundColor = UIColor.CustomColor.lightGray
            button.frame = popToRootButton.frame
            button.layer.cornerRadius = button.frame.height / 2
            
            return button
        }()
        
        if petEntity == nilEntity {
            rightBarButtonItem.customView = baseCameraButton
        } else {
            rightBarButtonItem.customView = baseEditedButton
        }
        
        popToRootButton.addTarget(self, action: #selector(popToRootController), for: .touchUpInside)
        
        leftBarButtonItem.customView = popToRootButton
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.tintColor = UIColor.CustomColor.dark
        navigationItem.rightBarButtonItem?.tintColor = UIColor.CustomColor.dark
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    func setupConstraints() {
        [titleImage,
         collectionView,
         backgroundView,
         picker,
         saveDateButton].forEach { view.addSubview($0) }
        
        titleImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        titleImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        titleImage.heightAnchor.constraint(equalToConstant: view.bounds.height / 2.7).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        picker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        picker.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        saveDateButton.widthAnchor.constraint(equalTo: picker.widthAnchor).isActive = true
        saveDateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveDateButton.topAnchor.constraint(equalTo: picker.bottomAnchor,
                                            constant: 8).isActive = true
        saveDateButton.addConstraint(NSLayoutConstraint(item: saveDateButton,
                                                        attribute: .width,
                                                        relatedBy: .equal,
                                                        toItem: saveDateButton,
                                                        attribute: .height,
                                                        multiplier: 6,
                                                        constant: 0))
    }
    
    func setupElements() {
        [titleImage,
         backgroundView,
         picker,
         saveDateButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
         }
        
        titleImage.image = petEntity.image ?? UIImage()
        titleImage.contentMode = .scaleAspectFill
        titleImage.backgroundColor = .white
        titleImage.clipsToBounds = true
        
        backgroundView.isHidden = true
        backgroundView.backgroundColor = UIColor.CustomColor.darkGray
        backgroundView.alpha = 0
        
        let tappedView = UITapGestureRecognizer(target: self, action: #selector(self.hideDatePicker(_:)))
        backgroundView.addGestureRecognizer(tappedView)
        backgroundView.isUserInteractionEnabled = true
        
        picker.isHidden = true
        picker.date = Date()
        picker.datePickerMode = .date
        picker.alpha = 0
        picker.layer.cornerRadius = 20
        picker.layer.masksToBounds = true
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels
            picker.backgroundColor = UIColor.CustomColor.lightGray
        } else {
            picker.backgroundColor = UIColor.CustomColor.lightGray
        }
        
        saveDateButton.isHidden = true
        saveDateButton.layoutIfNeeded()
        saveDateButton.setTitle("Сохранить", for: .normal)
        saveDateButton.backgroundColor = UIColor.CustomColor.purple
        saveDateButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        saveDateButton.setTitleColor(.white, for: .normal)
        saveDateButton.titleLabel?.adjustsFontSizeToFitWidth = true
        saveDateButton.alpha = 0
        saveDateButton.layer.cornerRadius = saveDateButton.frame.height / 2
        saveDateButton.addTarget(self, action: #selector(savePetBirthday), for: .touchUpInside)
    }
}
