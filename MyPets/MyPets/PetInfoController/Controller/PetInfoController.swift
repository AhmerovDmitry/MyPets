//
//  PetInfoController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 13.08.2021.
//

import UIKit

final class PetInfoController: UIViewController {
    // MARK: - Properties
    private let petModel = PetInfoModel()
    private let petInfoView = PetInfoView(frame: UIScreen.main.bounds)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        petInfoView.configureCell(petModel)
        setupNavigationController()
        addSubview()
        presentInputInfoController()
    }
}
    
// MARK: - Methods
extension PetInfoController {
    private func setupNavigationController() {
        navigationController?.navigationBar.backgroundColor = .clear
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "camera"), style: .done, target: nil, action: nil
        )
        navigationItem.rightBarButtonItem?.tintColor = UIColor.CustomColor.dark
    }
    private func addSubview() {
        view.addSubview(petInfoView)
    }
    private func presentInputInfoController() {
        petInfoView.presentControllerCallBack = { [weak self] in
            let controller = InputInfoController()
            controller.modalPresentationStyle = .overFullScreen
            controller.modalTransitionStyle = .crossDissolve
            self?.present(controller, animated: true, completion: nil)
        }
    }
}

// MARK: - Actions
extension PetInfoController {
    @objc private func dismissController() {
        dismiss(animated: true, completion: nil)
    }
}
