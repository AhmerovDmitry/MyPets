//
//  LocationViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 15.10.2020.
//

import UIKit
import YandexMapKit

class LocationViewController: UIViewController {
    private let backgroundView = UIImageView()
//    private let collectionView: UICollectionView = {
//        let cv = UICollectionView()
//
//        return cv
//    }()
    let mapView = YMKMapView()
    private let mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupConstraint()
        setupViewsAndLabels()
        
        userLocation()
        mapView.mapWindow.map.move(
            with: YMKCameraPosition(target: YMKPoint(latitude: 60, longitude: 30),
                                    zoom: 15,
                                    azimuth: 0,
                                    tilt: 0),
            animationType: YMKAnimation(type: YMKAnimationType.smooth,
                                        duration: 5))
    }
}

extension LocationViewController: GeneralSetupProtocol {
    func setupConstraint() {
        view.addSubview(mapView)
        view.addSubview(backgroundView)
                
        mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: backgroundView.topAnchor,
                                        constant: 10).isActive = true
        mapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundView.heightAnchor.constraint(equalTo: view.heightAnchor,
                                               multiplier: 0.2,
                                               constant: 0).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupViewsAndLabels() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = .gray
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        backgroundView.layer.shadowColor = UIColor.CustomColor.dark.cgColor
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundView.layer.shadowOpacity = 0.7
        backgroundView.layer.shadowRadius = 5
        
        mapView.mapType = .standard
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        
    }
    
    func presentController() {
    }
}
