//
//  Map Settings.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 21.10.2020.
//

import UIKit
import MapKit
import YandexMapsMobile

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
            
            searchManager = YMKSearch.sharedInstance().createSearchManager(with: .combined)
            
            mapView.mapWindow.map.isRotateGesturesEnabled = false
            mapView.mapWindow.map.addCameraListener(with: self)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = YMKPoint(latitude: locations.last!.coordinate.latitude,
                                longitude: locations.last!.coordinate.longitude)
    }
    
    func onCameraPositionChanged(with map: YMKMap, cameraPosition: YMKCameraPosition, cameraUpdateReason: YMKCameraUpdateReason, finished: Bool) {
        if finished {
            userLocationLayer.resetAnchor()
            let responseHandler = {(searchResponse: YMKSearchResponse?, error: Error?) -> Void in
                if let response = searchResponse {
                    self.onSearchResponse(response)
                } else {
                    self.onSearchError(error!)
                }
            }
            
            searchSession = searchManager!.submit(
                withText: searchResponseText,
                geometry: YMKVisibleRegionUtils.toPolygon(with: map.visibleRegion),
                searchOptions: YMKSearchOptions(),
                responseHandler: responseHandler)
        }
    }
    
    func onSearchResponse(_ response: YMKSearchResponse) {
        let mapObjects = mapView.mapWindow.map.mapObjects
        mapObjects.clear()
        for searchResult in response.collection.children {
            if let point = searchResult.obj?.geometry.first?.point {
                let placemark = mapObjects.addPlacemark(with: point)
                placemark.setIconWith(UIImage(named: "petIcon")!)
            }
        }
    }
    
    func onSearchError(_ error: Error) {
        let searchError = (error as NSError).userInfo[YRTUnderlyingErrorKey] as! YRTError
        var errorMessage = "Unknown error"
        if searchError.isKind(of: YRTNetworkError.self) {
            errorMessage = "Network error"
        } else if searchError.isKind(of: YRTRemoteError.self) {
            errorMessage = "Remote server error"
        }
        
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}
