//
//  Map Settings.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 21.10.2020.
//

import UIKit
import MapKit

extension LocationViewController : CLLocationManagerDelegate {
    //MARK: - Fetch user location
    func fetchLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
        } else {
            alertController.showAlertForMap(title: "Выключена служба геолокации",
                                            message: "Включить?",
                                            urlForSystemWay: "App-Prefs:root=LOCATION_SERVICES")
        }
    }
    
    func showUserLocation() {
        if let userLocation = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(viewRegion, animated: true)
        }
        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }
    }
    
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
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    
    func searchInMap(place: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = place
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        request.region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: span)
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: {(response, error) in
            for item in response!.mapItems {
                self.addPinToMapView(title: item.name, latitude: item.placemark.location!.coordinate.latitude, longitude: item.placemark.location!.coordinate.longitude)
            }
        })
    }
    
    func  addPinToMapView(title: String?, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        if let title = title {
            let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = title
            
            mapView.addAnnotation(annotation)
        }
    }
}
