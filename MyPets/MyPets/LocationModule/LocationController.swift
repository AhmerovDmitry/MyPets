//
//  LocationController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 14.09.2021.
//

import UIKit
import MapKit

final class LocationController: UIViewController {
    private let locationModel: LocationValueProtocol
    private let locationView: LocationView
    private let locationManager = CLLocationManager()
    private var matchingItems = [MKMapItem]()
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
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
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
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchInMap(place: locationModel.placemarkRequest[indexPath.item])
    }
}

extension LocationController: CLLocationManagerDelegate {
    func showUserLocation() {
        guard let userLocation = locationManager.location?.coordinate else { return }
        let viewRegion = MKCoordinateRegion(center: userLocation,
                                            latitudinalMeters: 1000,
                                            longitudinalMeters: 1000)
        locationView.setRegion(viewRegion, animated: true)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }

    func searchInMap(place: String?) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = place
        request.region = locationView.region()
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: { response, _ in
            guard let response = response else { return }
            self.matchingItems = response.mapItems
            self.dropPinZoomIn(placemarks: self.matchingItems)
        })
    }

    func dropPinZoomIn(placemarks: [MKMapItem]) {
        locationView.removeAnotation()
        var annotations = [MKPointAnnotation]()
        for item in placemarks {
            let annotation = MKPointAnnotation()
            annotation.coordinate = item.placemark.coordinate
            annotation.title = item.name
            if let title = item.placemark.title, let phone = item.phoneNumber {
                annotation.subtitle = "\(title) \n\(phone)"
            }
            annotations.append(annotation)
        }
        locationView.addAnnotations(annotations)
    }
}
