//
//  PetInfoViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 28.10.2020.
//

import UIKit

class PetInfoViewController: UIViewController {
    var petInfo: String?
    private let titleImage = UIImageView()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = .clear
        
        view.backgroundColor = .white
                
        setupConstraint()
        setupViewsAndLabels()
    }
}

extension PetInfoViewController: GeneralSetupProtocol {
    func setupConstraint() {
        [titleImage, collectionView].forEach { view.addSubview($0) }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        titleImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        titleImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        titleImage.heightAnchor.constraint(lessThanOrEqualToConstant: 300).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: titleImage.bottomAnchor,
                                            constant: -64).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor,
                                             constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor,
                                              constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupViewsAndLabels() {
        titleImage.translatesAutoresizingMaskIntoConstraints = false
        titleImage.contentMode = .scaleAspectFill
        titleImage.image = UIImage(named: "titleImage")
    }
    
    @objc func presentController() {}
}

extension PetInfoViewController: PetViewControllerDelegate, UITextFieldDelegate {
    func showDatePicker() {
        let backgroundView: UIView = {
            let bg = UIView()
            bg.translatesAutoresizingMaskIntoConstraints = false
            bg.backgroundColor = UIColor.CustomColor.darkGray
            bg.alpha = 0
            
            return bg
        }()
        
        let picker: UIDatePicker = {
            let localeId = Locale.preferredLanguages.first
            let picker = UIDatePicker()
            picker.locale = Locale(identifier: localeId!)
            picker.date = Date()
            picker.datePickerMode = .date
            picker.alpha = 0
            picker.layer.cornerRadius = 20
            picker.layer.masksToBounds = true
            picker.backgroundColor = UIColor.CustomColor.lightGray
            picker.translatesAutoresizingMaskIntoConstraints = false
            
            return picker
        }()
        let savePetButton: UIButton = {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Сохранить", for: .normal)
            //button.backgroundColor = UIColor.CustomColor.purple
            button.backgroundColor = .clear
            button.tintColor = .white
            button.layer.cornerRadius = button.frame.height / 2
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.alpha = 0
            button.addTarget(self, action: #selector(saveData), for: .touchUpInside)
            
            return button
        }()
        
        [backgroundView, picker, savePetButton].forEach { view.addSubview($0) }
        
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        picker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        picker.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        savePetButton.leftAnchor.constraint(equalTo: view.leftAnchor,
                                        constant: 32).isActive = true
        savePetButton.rightAnchor.constraint(equalTo: view.rightAnchor,
                                         constant: -32).isActive = true
        savePetButton.topAnchor.constraint(equalTo: picker.bottomAnchor, constant: 8).isActive = true
        savePetButton.addConstraint(NSLayoutConstraint(item: savePetButton,
                                                   attribute: .width,
                                                   relatedBy: .equal,
                                                   toItem: savePetButton,
                                                   attribute: .height,
                                                   multiplier: 6,
                                                   constant: 0))
        
        UIView.animate(withDuration: 0.5) {
            picker.alpha = 1
            backgroundView.alpha = 0.5
            savePetButton.alpha = 1
        }
        
    }
    
    func petInfoForModel() -> String? {
        return petInfo
    }
    
    func showAlertController(title: String,
                             message: String,
                             tableView: UITableView,
                             indexPath: IndexPath,
                             updateInformation: @escaping (IndexPath) -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.textAlignment = .left
            textField.textColor = UIColor.CustomColor.dark
            textField.placeholder = "Введите информацию о питомце"
            textField.addTarget(self, action: #selector(self.textFieldDidChangeSelection(_:)), for: .editingChanged)
        }
        let saveButton = UIAlertAction(title: "Сохранить", style: .default) { _ in
            updateInformation(indexPath)
            tableView.reloadData()
        }
        let cancelButton = UIAlertAction(title: "Отменить", style: .cancel)
        alert.addAction(saveButton)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func textFieldDidChangeSelection(_ textField: UITextField) {
        petInfo = textField.text
    }
}
