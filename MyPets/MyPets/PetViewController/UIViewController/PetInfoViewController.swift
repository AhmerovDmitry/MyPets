//
//  PetInfoViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 28.10.2020.
//

import UIKit

class PetInfoViewController: UIViewController {
    var tableView = UITableView()
    var indexPath = IndexPath()
    var updateInfo: ((IndexPath) -> ())?
    
    let backgroundView = UIView()
    let picker = UIDatePicker()
    let localeId = Locale.preferredLanguages.first
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
        cv.allowsSelection = false
        cv.clipsToBounds = false
        cv.layer.masksToBounds = false
        cv.bounces = false
        
        return cv
    }()
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        let addPhotoButton = UIBarButtonItem(image: UIImage(named: "cameraIcon"), style: .done, target: self, action: #selector(presentController))
        
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = UIColor.CustomColor.dark
        navigationItem.rightBarButtonItem = addPhotoButton
        navigationItem.rightBarButtonItem?.tintColor = UIColor.CustomColor.dark
        
        view.backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupConstraints()
        setupElements()
    }
}

extension PetInfoViewController: GeneralSetupProtocol {
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
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height / 3.5).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor,
                                             constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor,
                                              constant: 0).isActive = true
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
        
        titleImage.contentMode = .scaleAspectFill
        titleImage.backgroundColor = UIColor.CustomColor.lightGray
        titleImage.clipsToBounds = true
        
        backgroundView.isHidden = true
        backgroundView.backgroundColor = UIColor.CustomColor.darkGray
        backgroundView.alpha = 0
        
        picker.isHidden = true
        picker.locale = Locale(identifier: localeId!)
        picker.date = Date()
        picker.datePickerMode = .date
        picker.alpha = 0
        picker.layer.cornerRadius = 20
        picker.layer.masksToBounds = true
        picker.backgroundColor = UIColor.CustomColor.lightGray
        
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
            self.backgroundView.isHidden = false
            self.savePetButton.isHidden = false
            self.picker.alpha = 1
            self.backgroundView.alpha = 0.5
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
