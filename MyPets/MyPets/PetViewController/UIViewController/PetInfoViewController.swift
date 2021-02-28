//
//  PetInfoViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 28.10.2020.
//

import UIKit

class PetInfoViewController: UIViewController {
    var createOrChange = Bool()
    let nilEntity = PetModel()
    var petEntity = PetModel()
    var collectionItemIndex = 0
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
        CollectionModel(image: UIImage(named: "funIcon"),
                        title: "Развлечения",
                        description: "Игры и развлечения питомца"),
    ]
    var tableView = UITableView()
    var indexPath = IndexPath()
    var updateInfo: ((IndexPath) -> ())?
    
    let backgroundView = UIView()
    let picker = UIDatePicker()
    let savePetButton = UIButton(type: .system)
    var petInfo: String?
    var titleImage = UIImageView()
    private let collectionView: UICollectionView = {
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
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if petEntity == nilEntity {
            createOrChange = true
        } else {
            createOrChange = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationController()
        setupConstraints()
        setupElements()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if petEntity != nilEntity {
            switch createOrChange {
            case true: delegate?.createEntity(petEntity)
            case false: delegate?.updateEntity(petEntity, at: collectionItemIndex)
            }
        }
        delegate?.reloadCollectionView()
        delegate?.reloadController()
    }
}

extension PetInfoViewController: GeneralSetupProtocol {
    func setupNavigationController() {
        let addPhotoButton = UIBarButtonItem(image: UIImage(named: "cameraIcon"), style: .done, target: self, action: #selector(presentController))
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = UIColor.CustomColor.dark
        navigationItem.rightBarButtonItem = addPhotoButton
        navigationItem.rightBarButtonItem?.tintColor = UIColor.CustomColor.dark
    }
    
    func setupConstraints() {
        [titleImage,
         collectionView,
         backgroundView,
         picker,
         savePetButton].forEach { view.addSubview($0) }
        
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
        
        savePetButton.widthAnchor.constraint(equalTo: picker.widthAnchor).isActive = true
        savePetButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        savePetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        savePetButton.topAnchor.constraint(equalTo: picker.bottomAnchor,
                                           constant: 8).isActive = true
    }
    
    func setupElements() {
        [titleImage,
         backgroundView,
         picker,
         savePetButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
         }
        
        titleImage.image = petEntity.image ?? UIImage()
        titleImage.contentMode = .scaleAspectFill
        titleImage.backgroundColor = .white
        titleImage.clipsToBounds = true
        
        backgroundView.isHidden = true
        backgroundView.backgroundColor = UIColor.CustomColor.darkGray
        backgroundView.alpha = 0
        
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
        
        savePetButton.isHidden = true
        savePetButton.setTitle("Сохранить", for: .normal)
        savePetButton.backgroundColor = UIColor.CustomColor.purple
        savePetButton.tintColor = UIColor.CustomColor.lightGray
        savePetButton.titleLabel?.adjustsFontSizeToFitWidth = true
        savePetButton.alpha = 0
        savePetButton.layer.cornerRadius = 20
        savePetButton.addTarget(self, action: #selector(saveData), for: .touchUpInside)
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
            self.savePetButton.isHidden = false
            self.savePetButton.alpha = 1
        }
    }
    func showAlertController(title: String,
                             message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.textAlignment = .left
            textField.textColor = UIColor.CustomColor.dark
            textField.placeholder = "Введите информацию о питомце"
            textField.addTarget(self, action: #selector(self.textFieldDidChangeSelection(_:)), for: .editingChanged)
        }
        let saveButton = UIAlertAction(title: "Сохранить", style: .default) { _ in
            self.updatePetInfo(updateInformation: self.updateInfo!)
            
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
