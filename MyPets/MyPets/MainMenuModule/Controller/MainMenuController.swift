//
//  MainMenuController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 11.08.2021.
//

import UIKit
import MapKit

final class MainMenuController: UIViewController {

    // MARK: - Property

    private let weatherNetworkService = NetworkService(httpAdditionalHeaders: nil)
    private lazy var imagesNetworkService = NetworkService(httpAdditionalHeaders: mainModel.httpAdditionalHeaders)
    var locationManager = CLLocationManager()

    let mainView = MainMenuView(frame: UIScreen.main.bounds)
    var mainModel = MainWeatherModelImpl()

    var isGetUserCoordinate = false {
        didSet {
            if isGetUserCoordinate {
                loadData()
            }
        }
    }

    // MARK: - Init / Lifecycle

    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager = CLLocationManager()
        mainView.startShimmerAnimation()
        checkLoactionEnable()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewWillAppear(animated)
        locationManager.delegate = nil
        isGetUserCoordinate = false
        mainView.stopShimmerAnimation()
        weatherNetworkService.cancelNetworkRequest()
        imagesNetworkService.cancelNetworkRequest()
    }

    // MARK: - UI

    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.CustomColor.dark]
        navigationItem.title = "Главная"
    }
}

// MARK: - Methods

extension MainMenuController {
    private func loadData() {
        var state: String?
        var temp: String?
        var description: String?
        var mainImage: UIImage?
        var backgroundImage: UIImage?

        let serialQueue = DispatchQueue(label: "com.ahmerovdmitry.mypets")
        let dispatchGroup = DispatchGroup()

        // Получение данных о погоде (температура и статус погоды)

        dispatchGroup.enter()
        serialQueue.async { [weak self] in
            self?.weatherNetworkService.loadJSONData(from: self?.mainModel.weatherURL,
                                                     decodeModel: WeatherDescription.self) { result in
                switch result {
                case .success(let data):
                    state = data.weather.last?.main
                    description = "\(data.name ?? "")\n\(data.weather.last?.description?.firstUppercased ?? "")"
                    temp = "\(Int(round(data.main.temp ?? 0.0)))"
                case .failure(let error):
                    self?.networkError(error, withTitle: "Сетевая ошибка"); return
                }
                dispatchGroup.leave()
            }
        }

        // Получение картинок

        serialQueue.async { [weak self] in
            dispatchGroup.wait()
            dispatchGroup.enter()
            self?.imagesNetworkService.loadJSONData(from: self?.mainModel.imagesURL,
                                                    decodeModel: WeatherImages.self) { result in
                switch result {
                case .success(let data):
                    let randomNumber = Int.random(in: 0...data.homeImages.count - 1)
                    switch state {
                    case "Clear", "Clouds", "Drizzle", "Haze":
                        mainImage = self?.imagesNetworkService.downloadImage(at: data.strollImages[randomNumber])
                    default: mainImage = self?.imagesNetworkService.downloadImage(at: data.homeImages[randomNumber])
                    }
                    backgroundImage = self?.imagesNetworkService.downloadImage(at: data.backgroundImage)
                    DispatchQueue.main.async {
                        self?.mainView.stopShimmerAnimation()
                        self?.mainView.weatherView.presentWeatherElements(
                            temp: temp, city: description, mainImage: mainImage, bgImage: backgroundImage)
                    }
                case .failure(let error):
                    self?.networkError(error, withTitle: "Сетевая ошибка"); return
                }
                dispatchGroup.leave()
            }
        }
    }

    /// Метод сетевой ошибки, работает асинхронно в главном потоке
    /// передает nil в элементы вью с погодой, что с свою очеред устанавливает дефолтные зачения
    /// - Parameters:
    ///   - error: Описание ошибки
    ///   - withTitle: Заголовок ошибки

    private func networkError(_ error: NetworkServiceError, withTitle: String) {
        DispatchQueue.main.async {
            self.mainView.stopShimmerAnimation()
            UIAlertController.presentAlertWithBasicType(self, title: withTitle, message: error.message, style: .alert)
            self.mainView.weatherView.presentWeatherElements(temp: nil, city: nil, mainImage: nil, bgImage: nil)
        }
    }
}
