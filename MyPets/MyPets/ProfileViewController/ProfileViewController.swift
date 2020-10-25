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
    private let mapView = YMKMapView()
    private var nativeLocationManager = CLLocationManager()
    private var locationManager: YMKLocationManager!
    var userLocation: YMKPoint? {
        didSet {
            guard userLocation != nil && userLocation?.latitude != 0 && userLocation?.longitude != 0 else { return }
            
            mapView.mapWindow.map.move(
                with: YMKCameraPosition.init(target: userLocation!, zoom: 16, azimuth: 0, tilt: 0),
                animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 1),
                cameraCallback: nil)
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
        mapView.mapWindow.map.isRotateGesturesEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchLocation()
    }
}

extension ProfileViewController: CLLocationManagerDelegate, YMKUserLocationObjectListener {
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
            break
        case .authorizedWhenInUse:
            setupLocationManager()
            break
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
        locationManager = YMKMapKit.sharedInstance().createLocationManager()
        
        let mapKit = YMKMapKit.sharedInstance()
        let userLocationLayer = mapKit.createUserLocationLayer(with: mapView.mapWindow)
        userLocationLayer.setVisibleWithOn(true)
        userLocationLayer.isHeadingEnabled = false
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = YMKPoint(latitude: locations.last!.coordinate.latitude,
                                longitude: locations.last!.coordinate.longitude)
    }
    
    func onObjectAdded(with view: YMKUserLocationView) {}
    
    func onObjectRemoved(with view: YMKUserLocationView) {}
    
    func onObjectUpdated(with view: YMKUserLocationView, event: YMKObjectEvent) {}
}
