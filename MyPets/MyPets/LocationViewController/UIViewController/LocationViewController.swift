//
//  LocationViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 15.10.2020.
//

import UIKit
import MapKit

class LocationViewController: UIViewController {
    // MARK: - Model
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
    // MARK: - All properties
    let backgroundView = UIView()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(LocationViewCell.self, forCellWithReuseIdentifier: "cellFilterId")
        collectionView.layer.cornerRadius = 10
        collectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return collectionView
    }()
    // MARK: - Alert controller
    let alertController = UIAlertController()
    // MARK: - Locations preperties
    let locationManager = CLLocationManager()
    let mapView = MKMapView()
    var matchingItems = [MKMapItem]()
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        locationManager.delegate = self
        setup()
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
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: backgroundView.leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: backgroundView.rightAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 7.5),
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor),
            backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundView.heightAnchor.constraint(equalToConstant: tabBarController!.tabBar.bounds.height + 20),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                   constant: -tabBarController!.tabBar.bounds.height)
        ])
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
    func setupNavigationController() {}
    func presentController() {}
}
