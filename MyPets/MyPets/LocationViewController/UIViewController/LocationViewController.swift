//
//  LocationViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 15.10.2020.
//

import UIKit
import MapKit

class LocationViewController: UIViewController {
    //MARK: - Model
    let models = [
        BaseModel(firstProperties: "Bce",
                  secondProperties: ""),
        BaseModel(firstProperties: "Зоомагазины",
                  secondProperties: "зоомагазин"),
        BaseModel(firstProperties: "Клиники",
                  secondProperties: "ветеринар"),
        BaseModel(firstProperties: "Парки",
                  secondProperties: "парк"),
        BaseModel(firstProperties: "Кафе и рестораны",
                  secondProperties: "кафе"),
        BaseModel(firstProperties: "Площадки для собак",
                  secondProperties: "площадка для собак"),
        BaseModel(firstProperties: "Отели для животных",
                  secondProperties: "гостиница для животных"),
        BaseModel(firstProperties: "Приюты",
                  secondProperties: "приют для животных")
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
        cv.layer.cornerRadius = 10
        cv.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return cv
    }()
    
    //MARK: - Alert controller
    let alertController = UIAlertController()
    
    //MARK: - Locations preperties
    let locationManager = CLLocationManager()
    let mapView = MKMapView()
    var matchingItems = [MKMapItem]()
    
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        locationManager.delegate = self
        
        setup()
        checkLocationAvailability()
    }
}

extension LocationViewController: GeneralSetupProtocol {
    func setup() {
        setupConstraints()
        setupElements()
    }
    
    func setupConstraints() {
        view.addSubview(mapView)
        view.addSubview(backgroundView)
        backgroundView.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: backgroundView.leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: backgroundView.rightAnchor).isActive = true
        
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
    
    func setupElements() {
        [collectionView,
         backgroundView,
         mapView].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
         })
        
        mapView.showsUserLocation = true
        mapView.mapType = .mutedStandard
        mapView.showsBuildings = true
        
        backgroundView.backgroundColor = .clear
        backgroundView.layer.shadowColor = UIColor.CustomColor.dark.cgColor
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundView.layer.shadowOpacity = 0.7
        backgroundView.layer.shadowRadius = 5
    }
    
    func presentController() {
    }
}
