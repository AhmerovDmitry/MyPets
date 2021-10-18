//
//  MapView.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 14.10.2021.
//

import UIKit
import MapKit

final class MapView: UIView {

    // MARK: - Property

    let cellID = "MapCellId"

    private let mapView: MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = true
        map.mapType = .mutedStandard
        map.showsBuildings = true
        return map
    }()
    private let requestBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        return view
    }()
    private let searchPlaceCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.layer.cornerRadius = UIView.basicCornerRadius
        collectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return collectionView
    }()

    // MARK: - Init / Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

//    override func layoutSubviews() {
//        super.layoutSubviews()
//        setCornerRadiusForElements()
//    }

    private func setupUI() {
        setSelfViewUI()
        setMapViewConstraints()
        setSearchPlaceCollectionViewConstraints()
        setRequestBackgroundViewConstraints()
    }
    private func setSelfViewUI() {
        self.backgroundColor = .white
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
    private func setSearchPlaceCollectionViewConstraints() {
        self.addSubview(searchPlaceCollectionView)
        searchPlaceCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchPlaceCollectionView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1),
            searchPlaceCollectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            searchPlaceCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            searchPlaceCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
    private func setRequestBackgroundViewConstraints() {
        self.addSubview(requestBackgroundView)
        requestBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            requestBackgroundView.topAnchor.constraint(equalTo: searchPlaceCollectionView.bottomAnchor),
            requestBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            requestBackgroundView.leftAnchor.constraint(equalTo: self.leftAnchor),
            requestBackgroundView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
}

// MARK: - Methods

extension MapView {
}

// MARK: - Public Methods

extension MapView {
    func collectionViewDelegateAndDataSource<T>(_ target: T) where T: UICollectionViewDelegate,
                                                                   T: UICollectionViewDataSource {
        searchPlaceCollectionView.register(MapCollectionCell.self, forCellWithReuseIdentifier: cellID)
        searchPlaceCollectionView.delegate = target
        searchPlaceCollectionView.dataSource = target
    }
}
