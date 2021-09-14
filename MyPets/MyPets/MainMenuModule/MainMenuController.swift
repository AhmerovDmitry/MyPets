//
//  MainMenuController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 11.08.2021.
//

import UIKit
import MapKit

final class MainMenuController: UIViewController {

    // MARK: - Properties
    private let networkService = NetworkService()
    private let locationManager = CLLocationManager()
    private var state: String?
    private var requestCount = 0

    private var checkerTemperature: String?
    private var checkerMainImage: UIImage?
    private var checkerBackgroundImage: UIImage?

    // MARK: - View & Model
    private var mainWeatherModel = MainWeatherModel()
    private let mainMenuView = MainMenuView(frame: UIScreen.main.bounds)

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mainMenuView.weatherMenuView.reloadWeatherButtonAction(self, #selector(reloadWeatherButtonAction))
        mainMenuView.weatherMenuView.startAnimation()
        setupNavigationController()
        addSubview()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkLoactionEnable()
    }
    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.CustomColor.dark]
        navigationItem.title = "Главная"
    }
    private func addSubview() {
        view.addSubview(mainMenuView)
        mainMenuView.setDefaultShadow()
    }
    private func requestDataChecker() {
        guard let temperature = checkerTemperature else { return }
        guard let mainImage = checkerMainImage else { return }
        guard let backgroundImage = checkerBackgroundImage else { return }
        mainMenuView.weatherMenuView.setupTemperatureLabel(value: temperature)
        mainMenuView.weatherMenuView.setupMainImage(mainImage)
        mainMenuView.weatherMenuView.setupBackgroundImage(backgroundImage)
        mainMenuView.weatherMenuView.stopAnimation()
        mainMenuView.weatherMenuView.presentWeatherElements()
    }
    @objc private func reloadWeatherButtonAction() {
        checkLoactionEnable()
    }
}

// MARK: - Network Methods
extension MainMenuController {
    private func getWeatherInformation(at url: URL?) {
        guard let url = url else { return }

        networkService.loadJSONData(from: url, httpAdditionalHeaders: nil,
                                    decodeModel: WeatherDescription.self) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    guard let temp = data.main.temp else { return }
                    self?.state = data.weather.first?.main
                    self?.checkerTemperature = String(Int(round(temp)))
                    self?.requestDataChecker()
                }
            case .failure(let error):
                self?.retryingRequest(at: url, requestType: .weather, error: error)
            }
        }
    }
    private func getWeatherImages(at url: URL?) {
        guard let url = url else { return }

        networkService.loadJSONData(from: url, httpAdditionalHeaders: mainWeatherModel.httpAdditionalHeaders,
                                    decodeModel: WeatherImages.self) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async { [weak self] in
                    var index = 0
                    switch self?.state {
                    case "Clear", "Clouds", "Drizzle", "Haze":
                        if data.strollImages.count > 1 { index = Int.random(in: 0...data.strollImages.count - 1) }
                        self?.checkerMainImage = self?.downloadImage(at: data.strollImages[index])
                    default:
                        if data.homeImages.count > 1 { index = Int.random(in: 0...data.homeImages.count - 1) }
                        self?.checkerMainImage = self?.downloadImage(at: data.homeImages[index])
                    }
                    self?.checkerBackgroundImage = self?.downloadImage(at: data.backgroundImage)
                    self?.requestDataChecker()
                }
            case .failure(let error):
                self?.retryingRequest(at: url, requestType: .images, error: error)
            }
        }
    }

    /// Метод загружающий изображение по ссылке
    /// - Parameter string: URL в виде строки, преобразется внутри метода в запрос
    /// - Returns: Возвращает опциональную картинку
    private func downloadImage(at string: String?) -> UIImage? {
        guard let string = string else { return nil }
        guard let url = URL(string: string) else { return nil }
        guard let imageData = try? Data(contentsOf: url) else { return nil }
        let image = UIImage(data: imageData)
        return image
    }

    /// Метод повторного вызова функции запроса из сети
    /// - Parameters:
    ///   - url: адрес по которому происходит запрос в сеть
    ///   - requestType: enum который определяет запрос будет для погоды или для картинок
    ///   - error: ошибка для алерта которая отображается в случае если какая-то ошибка при запросе
    enum RequestType {
        case weather, images
    }
    private func retryingRequest(at url: URL, requestType: RequestType, error: Error?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self = self else { return }
            self.requestCount += 1
            if self.requestCount < 5 {
                switch requestType {
                case .weather:
                    self.getWeatherInformation(at: url)
                case .images:
                    self.getWeatherImages(at: url)
                }
            } else {
                UIAlertController.presentAlertWithRequestError(self, error: error) { [weak self] in
                    self?.mainMenuView.weatherMenuView.stopAnimation()
                    self?.mainMenuView.weatherMenuView.setupDefaultElements()
                }
                self.requestCount = 0
            }
        }
    }
}

// MARK: - Location Settings
extension MainMenuController: CLLocationManagerDelegate {
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }

    func checkLoactionEnable() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkAutorization()
        } else {
            UIAlertController.locationRequest(self, title: "Включить службу геолокации? 🤔",
                                              message: "Это нужно для получения погоды в вашей области.",
                                              systemWayUrl: "App-Prefs:root=LOCATION_SERVICES")
        }
    }

    func checkAutorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .denied:
            UIAlertController.locationRequest(
                self, title: "Вы запретили использовать местоположение. 😔",
                message: "Без определения местоположения мы не сможем показать погодные данные,"
                    + "хотите изменить свое решение?",
                systemWayUrl: UIApplication.openSettingsURLString
            )
            mainMenuView.weatherMenuView.stopAnimation()
            mainMenuView.weatherMenuView.setupDefaultElements()
        case .restricted:
            mainMenuView.weatherMenuView.stopAnimation()
            mainMenuView.weatherMenuView.setupDefaultElements()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first?.coordinate {
            mainWeatherModel.setUserCoordinate(lat: "\(location.latitude)", lon: "\(location.longitude)")
            mainMenuView.weatherMenuView.removeDefaultElements()
            mainMenuView.weatherMenuView.startAnimation()
            getWeatherInformation(at: mainWeatherModel.weatherURL)
            getWeatherImages(at: mainWeatherModel.imagesURL)
            locationManager.stopUpdatingLocation()
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAutorization()
    }
}
