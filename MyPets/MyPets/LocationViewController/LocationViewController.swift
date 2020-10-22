//
//  LocationViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 15.10.2020.
//

import UIKit
import MapKit

class LocationViewController: UIViewController {
    let backgroundView = UIImageView()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isScrollEnabled = true
        cv.isPagingEnabled = true
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(OnboardViewCell.self, forCellWithReuseIdentifier: "cellId")
        
        return cv
    }()
    
    let locationManager = CLLocationManager()
    let mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        locationManager.delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        backgroundView.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 10).isActive = true
        collectionView.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 10).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -10).isActive = true
        collectionView.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -10).isActive = true
        
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchLocation()
    }
}

extension LocationViewController: GeneralSetupProtocol {
    func setup() {
        setupConstraint()
        setupViewsAndLabels()
    }
    
    func setupConstraint() {
        view.addSubview(mapView)
        view.addSubview(backgroundView)
        
        mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: backgroundView.topAnchor,
                                        constant: 7.5).isActive = true
        mapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //        backgroundView.heightAnchor.constraint(equalTo: view.heightAnchor,
        //                                               multiplier: 0.2,
        //                                               constant: 0).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: (tabBarController?.tabBar.bounds.height)!).isActive = true
        backgroundView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: -(tabBarController?.tabBar.bounds.height)!
        ).isActive = true
    }
    
    func setupViewsAndLabels() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = .gray
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        backgroundView.layer.shadowColor = UIColor.CustomColor.dark.cgColor
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundView.layer.shadowOpacity = 0.7
        backgroundView.layer.shadowRadius = 5
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsUserLocation = true
    }
    
    func presentController() {
    }
}
