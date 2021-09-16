//
//  MainMenuController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 11.08.2021.
//

import UIKit
import MapKit

final class MainMenuController: UIViewController {
    let networkService: NetworkServiceProtocol = NetworkService()
    var locationManager = CLLocationManager()

    var mainWeatherModel = MainWeatherModel()
    let mainMenuView = MainMenuView(frame: UIScreen.main.bounds)

    var isGetUserCoordinate = false {
        didSet {
            if isGetUserCoordinate {
                loadData()
            }
        }
    }

    override func loadView() {
        view = mainMenuView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mainMenuView.setDefaultShadow()
        setupNavigationController()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager = CLLocationManager()
        mainMenuView.startShimmerAnimation()
        checkLoactionEnable()
    }
    override func viewWillDisappear(_ animated: Bool) {
        viewWillAppear(animated)
        locationManager.delegate = nil
        isGetUserCoordinate = false
        mainMenuView.stopShimmerAnimation()
        networkService.cancelNetworkRequest()
    }

    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.CustomColor.dark]
        navigationItem.title = "Главная"
    }
}

extension MainMenuController {
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
}

extension MainMenuController {
    @objc private func reloadWeatherButtonAction() {
        checkLoactionEnable()
    }

    private func loadData() {
        var state: String?
        var temperature: String?
        var mainImage: UIImage?
        var backgroundImage: UIImage?

        // Очередь и группа для того чтобы сначала получать данные о погоде
        // так как на их основании составляется запрос картинок

        let serialQueue = DispatchQueue(label: "com.mypets.serialqueue")
        let dispatchGroup = DispatchGroup()

        // Получение данных о погоде (температура и статус погоды)

        dispatchGroup.enter()
        serialQueue.async { [weak self] in
            guard let self = self else { return }
            self.networkService.loadJSONData(from: self.mainWeatherModel.weatherURL,
                                             httpAdditionalHeaders: nil,
                                             decodeModel: WeatherDescription.self) { result in
                switch result {
                case .success(let data):
                    guard let temp = data.main.temp else { return }
                    state = data.weather.last?.main
                    temperature = "\(Int(round(temp)))"
                    dispatchGroup.leave()
                case .failure(let error):
                    self.networkError(error, withTitle: "Сетевая ошибка")
                    dispatchGroup.leave()
                }
            }
        }

        // Получение картинок

        dispatchGroup.enter()
        serialQueue.async { [weak self] in
            guard let self = self else { return }
            self.networkService.loadJSONData(from: self.mainWeatherModel.imagesURL,
                                             httpAdditionalHeaders: self.mainWeatherModel.httpAdditionalHeaders,
                                             decodeModel: WeatherImages.self) { result in
                switch result {
                case .success(let data):
                    let randomNumber = Int.random(in: 0...data.homeImages.count - 1)
                    switch state {
                    case "Clear", "Clouds", "Drizzle", "Haze":
                        mainImage = self.loadImage(at: data.strollImages[randomNumber])
                    default:
                        mainImage = self.loadImage(at: data.homeImages[randomNumber])
                    }
                    backgroundImage = self.loadImage(at: data.backgroundImage)
                    dispatchGroup.leave()
                case .failure(let error):
                    self.networkError(error, withTitle: "Сетевая ошибка")
                    dispatchGroup.leave()
                }
            }
        }

        // Таймер для повтроной проверки данных каждые 2 секунды
        // в течении 60 секунд

        var requestTimer = 0

        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
            requestTimer += 1
            if requestTimer == 30 && (temperature == nil || mainImage == nil || backgroundImage == nil) {
                timer.invalidate()
                self.networkError(.network, withTitle: "Превышен интервал ожидания запроса")
            } else if (temperature != nil && mainImage != nil && backgroundImage != nil) {
                DispatchQueue.main.async {
                    timer.invalidate()
                    self.mainMenuView.stopShimmerAnimation()
                    self.mainMenuView.weatherMenuView.presentWeatherElements(temp: temperature,
                                                                             mainImage: mainImage,
                                                                             backgroundImage: backgroundImage)
                }
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
            self.mainMenuView.stopShimmerAnimation()
            UIAlertController.presentAlertWithBasicType(self,
                                                        title: withTitle,
                                                        message: error.message,
                                                        style: .actionSheet)
            self.mainMenuView.weatherMenuView.presentWeatherElements(temp: nil,
                                                                     mainImage: nil,
                                                                     backgroundImage: nil)
        }
    }

    /// Метод загрузки изображения из сети
    /// - Parameter url: Строка с сылкой на изображение
    /// - Returns: Полученное изображение из сети
    private func loadImage(at url: String) -> UIImage? {
        guard let url = URL(string: url) else { return nil }
        guard let imageData = try? Data(contentsOf: url) else { return nil }
        let image = UIImage(data: imageData)
        return image
    }
}
