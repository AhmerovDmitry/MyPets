//
//  LocationController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 14.09.2021.
//

import UIKit

final class LocationController: UIViewController {
    private let locationModel: LocationValueProtocol
    private let locationView: LocationView
    private let placemarkCollectionCellID = "placemarkCollectionCellID"

    init() {
        self.locationModel = LocationModel()
        self.locationView = LocationView(frame: UIScreen.main.bounds)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = locationView
        locationView.collectionViewDelegateAndDataSource(self)
        locationView.setCollectionViewID(placemarkCollectionCellID)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIAlertController.presentAlertWithBasicType(
            self,
            title: "Экран в разработке!",
            message: "Функциональность экрана может не соответствовать вашим ожиданиям, "
                + "так как он находится в разработке.",
            style: .actionSheet
        )
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension LocationController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = locationModel.placemarkTitle[indexPath.item]
        let itemSize = item.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
        return CGSize(width: itemSize.width + 50, height: collectionView.frame.height / 2)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locationModel.placemarkTitle.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: placemarkCollectionCellID,
            for: indexPath
        ) as? LocationCollectionCell else { return UICollectionViewCell() }
        cell.configureCell(locationModel.placemarkTitle[indexPath.item])
        cell.requestButtonAction(self, action: #selector(sendPlacemarkRequest))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
}

extension LocationController {
    @objc func sendPlacemarkRequest() {
        print("REQUEST")
    }
}
