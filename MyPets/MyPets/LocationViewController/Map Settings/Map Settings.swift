//
//  Map Settings.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 21.10.2020.
//

import UIKit
import MapKit

extension LocationViewController {
    //MARK: - Fetch user location
    func fetchLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
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
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
            showUserLocation()
            break
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
            showUserLocation()
            break
        case .denied:
            showAlert(title: "Вы запретили использование местоположения",
                      message: "Хотите это изменить?",
                      urlForSystemWay: UIApplication.openSettingsURLString)
        case .restricted:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            print("Default status")
        }
    }
    
    //MARK: - Settings for UIAlertController
    func showAlert(title: String, message: String?, urlForSystemWay url: String?) {
        guard let url = url else { return }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Настройки", style: .default) { (alert) in
            if let url = URL(string: url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(settingsAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func showUserLocation() {
        guard let userLocation = locationManager.location?.coordinate else { return }
        let viewRegion = MKCoordinateRegion(center: userLocation,
                                            latitudinalMeters: 2000,
                                            longitudinalMeters: 2000)
        mapView.setRegion(viewRegion, animated: true)
    }
}
//MARK: - CLLocationManagerDelegate
extension LocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
}
