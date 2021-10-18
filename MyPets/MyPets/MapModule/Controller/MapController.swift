//
//  MapController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 14.10.2021.
//

import UIKit

final class MapController: UIViewController {

    // MARK: - Property

//    var matchingItems = [MKMapItem]()

    let mapView = MapView(frame: UIScreen.main.bounds)
    let mapModel = MapModel()

    // MARK: - Init / Lifecycle

    override func loadView() {
        view = mapView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.collectionViewDelegateAndDataSource(self)
    }
}

extension MapController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = mapModel.buttonTitles[indexPath.item]
        let itemSize = item.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
        return CGSize(width: itemSize.width + 50, height: collectionView.frame.height / 2)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mapModel.buttonTitles.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: mapView.cellID, for: indexPath
        ) as? MapCollectionCell else { return UICollectionViewCell() }
        cell.configureCell(requestTitle: mapModel.buttonTitles[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
