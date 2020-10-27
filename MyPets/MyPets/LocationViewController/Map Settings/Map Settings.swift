//
//  Map Settings.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 21.10.2020.
//

import UIKit
import MapKit
import YandexMapKit

extension LocationViewController: CLLocationManagerDelegate, YMKMapCameraListener {
    //MARK: - Fetch user location
    func fetchLocation() {
            if CLLocationManager.locationServicesEnabled() {
                nativeLocationManager.delegate = self
                nativeLocationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                nativeLocationManager.startUpdatingLocation()
                checkAuthorization()
            } else {
                alertController.showAlert(title: "Выключена служба геолокации",
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
            alertController.showAlert(title: "Вы запретили использование местоположения",
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
