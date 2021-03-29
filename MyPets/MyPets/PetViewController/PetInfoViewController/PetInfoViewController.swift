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
    var collectionItemIndex: Int?
    weak var delegate: EntityTransfer?
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
//MARK: - Delegate methods
extension PetInfoViewController: PetViewControllerDelegate, UITextFieldDelegate {
    
    func fetchTableInfo(tableView: UITableView,
                        indexPath: IndexPath,
                        updateInformation: @escaping (IndexPath) -> ()) {
        self.tableView = tableView
        self.indexPath = indexPath
        self.updateInfo = updateInformation
    }
    
    func updatePetInfo(updateInformation: @escaping (IndexPath) -> ()) {
        updateInformation(indexPath)
    }
    
    func showDatePicker() {
        UIView.animate(withDuration: 0.5) {
            self.picker.isHidden = false
            self.picker.alpha = 1
            self.backgroundView.isHidden = false
            self.backgroundView.alpha = 0.5
            self.saveDateButton.isHidden = false
            self.saveDateButton.alpha = 1
        }
    }
    
    func showAlertController(title: String,
                             message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { textField in
            switch self.indexPath.row {
            case 0:
                textField.text = self.petEntity.name ?? ""
            case 1:
                textField.text = self.petEntity.kind ?? ""
            case 2:
                textField.text = self.petEntity.breed ?? ""
            case 4:
                textField.text = self.petEntity.weight ?? ""
            case 5:
                textField.text = self.petEntity.sterile ?? ""
            case 6:
                textField.text = self.petEntity.color ?? ""
            case 7:
                textField.text = self.petEntity.hair ?? ""
            case 8:
                textField.text = self.petEntity.chipNumber ?? ""
            default: break
            }
            textField.textAlignment = .left
            textField.textColor = UIColor.CustomColor.dark
            textField.placeholder = "Введите информацию о питомце"
            textField.addTarget(self,
                                action: #selector(self.textFieldDidChangeSelection(_:)),
                                for: .editingChanged)
        }
        let saveButton = UIAlertAction(title: "Сохранить", style: .default) { _ in
            if self.petInfo != nil {
                self.updatePetInfo(updateInformation: self.updateInfo!)
            }
            
            switch self.indexPath.row {
            case 0:
                self.petEntity.name = self.petInfo
            case 1:
                self.petEntity.kind = self.petInfo
            case 2:
                self.petEntity.breed = self.petInfo
            case 4:
                self.petEntity.weight = self.petInfo
            case 5:
                self.petEntity.sterile = self.petInfo
            case 6:
                self.petEntity.color = self.petInfo
            case 7:
                self.petEntity.hair = self.petInfo
            case 8:
                self.petEntity.chipNumber = self.petInfo
            default: break
            }
            self.tableView.reloadData()
            self.petInfo = nil
        }
        let cancelButton = UIAlertAction(title: "Отменить", style: .cancel)
        alert.addAction(saveButton)
        alert.addAction(cancelButton)
        
        present(alert, animated: true, completion: nil)
    }
    
    func petInfoForModel() -> String? {
        
        return petInfo
    }
    
}
