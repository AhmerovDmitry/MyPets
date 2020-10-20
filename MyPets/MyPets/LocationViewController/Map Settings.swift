//
//  Map Settings.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 20.10.2020.
//

import UIKit
import YandexMapKit

extension LocationViewController {
    func userLocation() {
        let mapKit = YMKMapKit.sharedInstance()
        let userLocation = mapKit.createUserLocationLayer(with: mapView.mapWindow)
        
        userLocation.setVisibleWithOn(true)
        userLocation.isHeadingEnabled = true
    }
}
