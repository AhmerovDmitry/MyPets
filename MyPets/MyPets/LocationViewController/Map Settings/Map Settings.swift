//
//  Map Settings.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 21.10.2020.
//

import UIKit
import MapKit

extension LocationViewController: CLLocationManagerDelegate {
    // MARK: - Fetch user location
    func checkLocationAvailability() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
        } else {
            alertController.showAlertForMap(title: "Выключена служба геолокации",
                                            message: "Включить?",
                                            urlForSystemWay: "App-Prefs:root=LOCATION_SERVICES")
        }
    }
    // MARK: - Check authorization status
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            manager.requestLocation()
            showUserLocation()
        case .denied:
            alertController.showAlertForMap(title: "Вы запретили использование местоположения",
                                            message: "Хотите это изменить?",
                                            urlForSystemWay: UIApplication.openSettingsURLString)
        case .restricted:
            break
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        default:
            print("Default status")
        }
    }
    // MARK: - error.localizedDescription
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    // MARK: - View user location
    func showUserLocation() {
        guard let userLocation = locationManager.location?.coordinate else { return }
        let viewRegion = MKCoordinateRegion(center: userLocation,
                                            latitudinalMeters: 1000,
                                            longitudinalMeters: 1000)
        mapView.setRegion(viewRegion, animated: true)
    }
    // MARK: - Did update user location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    // MARK: - Search annotation on map
    func searchInMap(place: String?) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = place
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: { response, _ in
            guard let response = response else { return }
            self.matchingItems = response.mapItems
            self.dropPinZoomIn(placemarks: self.matchingItems)
        })
    }
    // MARK: - Set pin and annotation settings
    func dropPinZoomIn(placemarks: [MKMapItem]) {
        mapView.removeAnnotations(mapView.annotations)
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
        mapView.addAnnotations(annotations)
    }
}
