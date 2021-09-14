//
//  LocationView.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 14.09.2021.
//

import UIKit
import MapKit

final class LocationView: UIView {
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.showsBuildings = true
        mapView.showsUserLocation = true
        mapView.mapType = .mutedStandard
        return mapView
    }()
    private let backgroundPlacemarkView = UIView()
    private let placemarkCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.layer.cornerRadius = 10
        collectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LocationView {
    private func setupUI() {
        setMapViewConstraints()
        setBackgroundPlacemarkViewConstraints()
        setPlacemarkCollectionConstraints()
    }
    private func setMapViewConstraints() {
        self.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mapView.leftAnchor.constraint(equalTo: self.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
    private func setBackgroundPlacemarkViewConstraints() {
        self.addSubview(backgroundPlacemarkView)
        backgroundPlacemarkView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundPlacemarkView.leftAnchor.constraint(equalTo: self.leftAnchor),
            backgroundPlacemarkView.rightAnchor.constraint(equalTo: self.rightAnchor),
            backgroundPlacemarkView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1),
            backgroundPlacemarkView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    private func setPlacemarkCollectionConstraints() {
        self.addSubview(placemarkCollection)
        placemarkCollection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placemarkCollection.topAnchor.constraint(equalTo: backgroundPlacemarkView.topAnchor),
            placemarkCollection.bottomAnchor.constraint(equalTo: backgroundPlacemarkView.bottomAnchor),
            placemarkCollection.leftAnchor.constraint(equalTo: backgroundPlacemarkView.leftAnchor),
            placemarkCollection.rightAnchor.constraint(equalTo: backgroundPlacemarkView.rightAnchor),
        ])
    }
}

extension LocationView {
    func collectionViewDelegateAndDataSource<T>(_ target: T) where T: UICollectionViewDelegate,
                                                                   T: UICollectionViewDataSource {
        placemarkCollection.delegate = target
        placemarkCollection.dataSource = target
    }
    func setCollectionViewID(_ id: String) {
        placemarkCollection.register(LocationCollectionCell.self, forCellWithReuseIdentifier: id)
    }
    func setRegion(_ region: MKCoordinateRegion, animated: Bool) {
        mapView.setRegion(region, animated: animated)
    }
    func region() -> MKCoordinateRegion {
        return mapView.region
    }
    func removeAnotation() {
        mapView.removeAnnotations(mapView.annotations)
    }
    func addAnnotations(_ annotations: [MKAnnotation]) {
        mapView.addAnnotations(annotations)
    }
}
