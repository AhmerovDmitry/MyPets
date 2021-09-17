//
//  MainMenuController + Extension.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 15.09.2021.
//

import Foundation
import MapKit

extension MainMenuController: CLLocationManagerDelegate {
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    func checkLoactionEnable() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkAutorization()
        } else {
            UIAlertController.locationRequest(self, title: "Включить службу геолокации? 🤔",
                                              message: "Это нужно для получения погоды в вашей области.",
                                              systemWayUrl: "App-Prefs:root=LOCATION_SERVICES")
        }
    }
    func checkAutorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .denied:
            UIAlertController.locationRequest(
                self, title: "Вы запретили использовать местоположение. 😔",
                message: "Без определения местоположения мы не сможем показать погодные данные,"
                    + "хотите изменить свое решение?",
                systemWayUrl: UIApplication.openSettingsURLString
            )
            mainView.stopShimmerAnimation()
        case .restricted:
            mainView.stopShimmerAnimation()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first?.coordinate {
            mainModel.setUserCoordinate(lat: "\(location.latitude)", lon: "\(location.longitude)")
            locationManager.stopUpdatingLocation()
            isGetUserCoordinate = true
        }
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAutorization()
    }
}
