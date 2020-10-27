//
//  ProfileViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 15.10.2020.
//

import UIKit
import YandexMapKit
import MapKit

class ProfileViewController: UIViewController {
    private var firstUserLocation = true
    private var firstShown = true
    private let nativeLocationManager = CLLocationManager()
    private var userLocationLayer: YMKUserLocationLayer!
    private let mapView = YMKMapView()
    private var locationManager: YMKLocationManager!
    var userLocation: YMKPoint? {
        didSet {
            if firstShown {
                firstShown = false
                guard userLocation != nil && userLocation?.latitude != 0 && userLocation?.longitude != 0 else { return }
                
                mapView.mapWindow.map.move(
                    with: YMKCameraPosition.init(target: userLocation!, zoom: 16, azimuth: 0, tilt: 0),
                    animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 2.5),
                    cameraCallback: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(mapView)
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mapView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: -(tabBarController?.tabBar.bounds.height)!
        ).isActive = true
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchLocation()
    }
}

extension ProfileViewController: CLLocationManagerDelegate, YMKMapCameraListener {
    //MARK: - Fetch user location
    func fetchLocation() {
        if CLLocationManager.locationServicesEnabled() {
            nativeLocationManager.delegate = self
            nativeLocationManager.desiredAccuracy = kCLLocationAccuracyBest
            nativeLocationManager.startUpdatingLocation()
            
            checkAuthorization()
        } else {
            showAlert(title: "Выключена служба геолокации",
                      message: "Включить?",
                      urlForSystemWay: "App-Prefs:root=LOCATION_SERVICES")
        }
    }
    //MARK: - CLLocationManager authorization status
    func checkAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            setupLocationManager()
        case .authorizedWhenInUse:
            setupLocationManager()
        case .denied:
            showAlert(title: "Вы запретили использование местоположения",
                      message: "Хотите это изменить?",
                      urlForSystemWay: UIApplication.openSettingsURLString)
        case .restricted:
            break
        case .notDetermined:
            nativeLocationManager.requestWhenInUseAuthorization()
        default:
            print("Default status")
        }
    }
    
    func setupLocationManager() {
        if firstUserLocation {
            firstUserLocation = false
            locationManager = YMKMapKit.sharedInstance().createLocationManager()
            
            let mapKit = YMKMapKit.sharedInstance()
            userLocationLayer = mapKit.createUserLocationLayer(with: mapView.mapWindow)
            userLocationLayer.setVisibleWithOn(true)
            userLocationLayer.isHeadingEnabled = false
            
            mapView.mapWindow.map.isRotateGesturesEnabled = false
            mapView.mapWindow.map.addCameraListener(with: self)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = YMKPoint(latitude: locations.last!.coordinate.latitude,
                                longitude: locations.last!.coordinate.longitude)
    }
    
    func onCameraPositionChanged(with map: YMKMap, cameraPosition: YMKCameraPosition, cameraUpdateSource: YMKCameraUpdateSource, finished: Bool) {
        userLocationLayer.resetAnchor()
    }
}
