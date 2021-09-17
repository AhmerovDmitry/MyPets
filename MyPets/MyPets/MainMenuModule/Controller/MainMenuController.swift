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

    var mainModel = MainWeatherModel()
    let mainView = MainMenuView(frame: UIScreen.main.bounds)

    var isGetUserCoordinate = false {
        didSet {
            if isGetUserCoordinate {
                loadData()
            }
        }
    }

    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.setDefaultShadow()
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
    private func loadData() {
        var state: String?, temp: String?, mainImage: UIImage?, backgroundImage: UIImage?

        // Очередь и группа для того чтобы сначала получать данные о погоде
        // так как на их основании составляется запрос картинок

        let serialQueue = DispatchQueue(label: "com.mypets.serialqueue")
        let dispatchGroup = DispatchGroup()

        // Получение данных о погоде (температура и статус погоды)

        dispatchGroup.enter()
        serialQueue.async { [weak self] in
            self?.networkService.loadJSONData(from: self?.mainModel.weatherURL, httpAdditionalHeaders: nil,
                                             decodeModel: WeatherDescription.self) { result in
                switch result {
                case .success(let data):
                    state = data.weather.last?.main
                    temp = "\(Int(round(data.main.temp ?? 0.0)))"
                    dispatchGroup.leave()
                case .failure(let error):
                    self?.networkError(error, withTitle: "Сетевая ошибка")
                    dispatchGroup.leave()
                }
            }
        }

        // Получение картинок

        dispatchGroup.enter()
        serialQueue.async { [weak self] in
            self?.networkService.loadJSONData(from: self?.mainModel.imagesURL,
                                             httpAdditionalHeaders: self?.mainModel.httpAdditionalHeaders,
                                             decodeModel: WeatherImages.self) { result in
                switch result {
                case .success(let data):
                    let randomNumber = Int.random(in: 0...data.homeImages.count - 1)
                    switch state {
                    case "Clear", "Clouds", "Drizzle", "Haze":
                        mainImage = self?.networkService.downloadImage(at: data.strollImages[randomNumber])
                    default:
                        mainImage = self?.networkService.downloadImage(at: data.homeImages[randomNumber])
                    }
                    backgroundImage = self?.networkService.downloadImage(at: data.backgroundImage)
                    dispatchGroup.leave()
                case .failure(let error):
                    self?.networkError(error, withTitle: "Сетевая ошибка")
                    dispatchGroup.leave()
                }
            }
        }

        var requestTimer = 0

        // Таймер для повтроной проверки данных каждые 2 секунды
        // в течении 60 секунд

        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
            requestTimer += 1
            self.networkDataChecker(
                temp: temp, main: mainImage, background: backgroundImage, timer: timer, requestTimer: requestTimer
            )
        }
    }

    /// Метод проверяющий данные полученные из сети
    /// - Parameters:
    ///   - temp: Температура
    ///   - main: Главное изображение
    ///   - background: Бекграундная картинка
    ///   - timer: Таймер для остановки
    ///   - requestTimer: Количество запросов для остановки в случае превышения 60 секунд
    func networkDataChecker(temp: String?,
                            main: UIImage?,
                            background: UIImage?,
                            timer: Timer,
                            requestTimer: Int) {
        if requestTimer == 30 && (temp == nil || main == nil || background == nil) {
            timer.invalidate()
            self.networkError(.network, withTitle: "Превышен интервал ожидания запроса")
        } else if temp != nil && main != nil && background != nil {
            DispatchQueue.main.async {
                timer.invalidate()
                self.mainView.stopShimmerAnimation()
                self.mainView.weatherView.presentWeatherElements(temp: temp,
                                                                 mainImage: main,
                                                                 backgroundImage: background)
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
            UIAlertController.presentAlertWithBasicType(self,
                                                        title: withTitle,
                                                        message: error.message,
                                                        style: .actionSheet)
            self.mainView.weatherView.presentWeatherElements(temp: nil,
                                                             mainImage: nil,
                                                             backgroundImage: nil)
        }
    }
}
