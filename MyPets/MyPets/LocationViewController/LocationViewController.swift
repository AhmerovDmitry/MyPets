//
//  LocationViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 15.10.2020.
//

import UIKit
import YandexMapKit

class LocationViewController: UIViewController, YMKUserLocationObjectListener {
    func onObjectAdded(with view: YMKUserLocationView) {
        
    }
    
    func onObjectRemoved(with view: YMKUserLocationView) {
        
    }
    
    func onObjectUpdated(with view: YMKUserLocationView, event: YMKObjectEvent) {
        
    }
    
    private let backgroundView = UIImageView()
    //    private let collectionView: UICollectionView = {
    //        let cv = UICollectionView()
    //
    //        return cv
    //    }()
    let mapView = YMKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setup()
        
//        userLocation()
//        mapView.mapWindow.map.move(
//            with: YMKCameraPosition(target: YMKPoint(latitude: 55.751574,
//                                                     longitude: 37.573856),
//                                    zoom: 15,
//                                    azimuth: 0,
//                                    tilt: 0),
//            animationType: YMKAnimation(type: YMKAnimationType.smooth,
//                                        duration: 5))

        mapView.mapWindow.map.isRotateGesturesEnabled = false
        mapView.mapWindow.map.move(with:
            YMKCameraPosition(target: YMKPoint(latitude: 0, longitude: 0), zoom: 14, azimuth: 0, tilt: 0))
        
        let scale = UIScreen.main.scale
        let mapKit = YMKMapKit.sharedInstance()
        let userLocationLayer = mapKit.createUserLocationLayer(with: mapView.mapWindow)

        userLocationLayer.setVisibleWithOn(true)
        userLocationLayer.isHeadingEnabled = true
        userLocationLayer.setAnchorWithAnchorNormal(
            CGPoint(x: 0.5 * mapView.frame.size.width * scale, y: 0.5 * mapView.frame.size.height * scale),
            anchorCourse: CGPoint(x: 0.5 * mapView.frame.size.width * scale, y: 0.83 * mapView.frame.size.height * scale))
        //userLocationLayer.setObjectListenerWith(self)
    }
}

extension LocationViewController: GeneralSetupProtocol {
    func setup() {
        setupConstraint()
        setupViewsAndLabels()
    }
    
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
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func presentController() {
    }
}
