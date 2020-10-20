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
        //let scale = UIScreen.main.scale
        let mapKit = YMKMapKit.sharedInstance()
        let userLocation = mapKit.createUserLocationLayer(with: mapView.mapWindow)
        
        userLocation.setVisibleWithOn(true)
        userLocation.isHeadingEnabled = true
//        userLocation.setAnchorWithAnchorNormal(
//            CGPoint(x: 0.5 * LocationViewController.mapView.frame.width * scale,
//                    y: 0.5 * LocationViewController.mapView.frame.height * scale
//            ),
//            anchorCourse: CGPoint(x: 0.5 * LocationViewController.mapView.frame.width * scale,
//                                  y: 0.83 * LocationViewController.mapView.frame.height * scale
//            ))
//        userLocation.setObjectListenerWith(self)
    }
}
