//
//  PetInfoController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 13.08.2021.
//

import UIKit

protocol TransferPetInformationDelegate: AnyObject {
    func transferPetInformation(_ information: String)
}

final class PetInfoController: UIViewController {
    // MARK: - Properties
    private var cellIndex: Int?
    private lazy var petModel: PetInfoModel = {
        var model = PetInfoModel()
        model.controller = self
        return model
    }()
    private lazy var petInfoView: PetInfoView = {
        let view = PetInfoView(frame: view.frame)
        return view
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationController()
        addSubview()
        presentInputInfoController()
        petInfoView.collectionViewDelegate(self)
        petInfoView.collectionViewDataSource(self)
        petInfoView.configureCell(petModel)
    }
}
// MARK: - Methods
extension PetInfoController {
    private func setupNavigationController() {
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.backgroundColor = .clear
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "camera"),
            style: .done,
            target: self,
            action: nil
        )
        navigationItem.rightBarButtonItem?.tintColor = UIColor.CustomColor.dark
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.uturn.left"),
            style: .done,
            target: self,
            action: #selector(popViewController)
        )
        navigationItem.leftBarButtonItem?.tintColor = UIColor.CustomColor.dark
    }
    private func saveEntityInCoreData() {
        CoreDataManager.shared.createEntity(petModel.defaultPet)
    }
    private func addSubview() {
        view.addSubview(petInfoView)
    }
    private func presentInputInfoController() {
        petInfoView.presentControllerCallBack = { [weak self] index in
            self?.cellIndex = index
            let controller = InputInfoController()
            controller.checkTextField(self?.petModel.petInformation[index])
            controller.delegate = self
            controller.modalPresentationStyle = .overFullScreen
            controller.modalTransitionStyle = .crossDissolve
            self?.present(controller, animated: true, completion: nil)
        }
    }
}

// MARK: - Actions
extension PetInfoController {
    @objc private func popViewController() {
        saveEntityInCoreData()
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Delegate & DataSource
extension PetInfoController: TransferPetInformationDelegate {
    public func transferPetInformation(_ information: String) {
        if let cellIndex = cellIndex {
            petModel.updateInformation(information, index: cellIndex)
        }
    }
    public func reloadTableViewData(_ value: PetInfoModel) {
        petInfoView.configureCell(value)
    }
}

extension PetInfoController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0: return CGSize(width: view.bounds.width / 1.1, height: view.bounds.height / 1.7)
        default: return CGSize(width: view.bounds.width / 1.1, height: view.bounds.height / 9)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: petInfoView.cellID,
            for: indexPath
        ) as? PetInfoCollectionCell else { return UICollectionViewCell() }
        indexPath.row == 0 ? petInfoView.setPetInfoCollectionInCell(cell) : nil
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: view.bounds.height / 9, left: 0, bottom: 15, right: 0)
    }
}
