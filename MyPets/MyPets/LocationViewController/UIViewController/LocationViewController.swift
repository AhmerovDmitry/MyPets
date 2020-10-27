//
//  LocationViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 15.10.2020.
//

import UIKit
import MapKit
import YandexMapKit

class LocationViewController: UIViewController {
    //MARK: - Model
    let models = [
        LocationModel(text: "Bce"),
        LocationModel(text: "Зоомагазины"),
        LocationModel(text: "Клиники"),
        LocationModel(text: "Парки"),
        LocationModel(text: "Кафе и рестораны"),
        LocationModel(text: "Площадки для собак"),
        LocationModel(text: "Отели для животных"),
        LocationModel(text: "Приюты")
    ]
    //MARK: - All properties
    let backgroundView = UIView()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        cv.register(LocationViewCell.self, forCellWithReuseIdentifier: "cellFilterId")
        
        return cv
    }()
    //MARK: - Alert controller
    let alertController = UIAlertController()
    //MARK: - Locations preperties
    var firstUserLocation = true
    var firstShown = true
    let nativeLocationManager = CLLocationManager()
    var userLocationLayer: YMKUserLocationLayer!
    let mapView = YMKMapView()
    var locationManager: YMKLocationManager!
    var userLocation: YMKPoint? {
        didSet {
            if firstShown {
                firstShown = false
                guard userLocation != nil && userLocation?.latitude != 0 && userLocation?.longitude != 0 else { return }
                
                mapView.mapWindow.map.move(
                    with: YMKCameraPosition.init(target: userLocation!, zoom: 16, azimuth: 0, tilt: 0),
                    animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 2.5),
                    cameraCallback: nil)
            }
        }
    }
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        backgroundView.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: backgroundView.leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: backgroundView.rightAnchor).isActive = true
        
        setup()
    }
    //MARK: - viewDidAppear
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
        
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: backgroundView.topAnchor,
                                        constant: 7.5).isActive = true
        mapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: (tabBarController?.tabBar.bounds.height)! + 20).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                               constant: -(tabBarController?.tabBar.bounds.height)!).isActive = true
    }
    
    func setupViewsAndLabels() {
        [collectionView,
         backgroundView,
         mapView].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
         })
        
        backgroundView.backgroundColor = .white
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        backgroundView.layer.shadowColor = UIColor.CustomColor.dark.cgColor
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundView.layer.shadowOpacity = 0.7
        backgroundView.layer.shadowRadius = 5
    }
    
    func presentController() {
    }
}
