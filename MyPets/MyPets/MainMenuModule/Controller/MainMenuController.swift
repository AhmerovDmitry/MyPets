//
//  MainMenuController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 11.08.2021.
//

import UIKit

final class MainMenuController: UIViewController {
    // MARK: - Properties
    private var state: String?
    private let mainWeatherModel = MainWeatherModel.shared
    private let mainMenuView = MainMenuView(frame: UIScreen.main.bounds)
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        addSubview()
        preapareNetworkDataToPresent()
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
    private func setWeatherTitle(_ value: Int) {
        mainMenuView.setupTemperatureLabel(value: value)
    }
    private func setBackgroundImage(_ image: UIImage) {
        mainMenuView.setupBackgroundImage(image)
    }
    private func setMainImage(_ image: UIImage) {
        mainMenuView.setupMainImage(image)
    }
    private func stopAnimation() {
        mainMenuView.stopAnimation()
    }
    private func presentWeatherElements() {
        mainMenuView.presentWeatherElements()
    }
}
// MARK: - Network Methods
/// Метод работы с сетью
extension MainMenuController {
    /// МЕТОД ЗАГРУЗКИ ИНФОРМАЦИИ О ПОГОДЕ
    private func getWeatherInformation(at url: URL?) {
        guard let url = url else { return }
        NetworkingManager.shared.loadJSONData(from: url, configuration: .default) { [weak self] result in
            switch result {
            case .success(let data):
                let weatherData = try? JSONDecoder().decode(GeneralWeather.self, from: data)
                /// Установка состояния погоды для загрузки нужной картинки
                self?.state = weatherData?.weather.first?.main
                if let temp = weatherData?.main.temp {
                    self?.setWeatherTitle(Int(round(temp)))
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    private func getWeatherImages(at url: URL?) {
        guard let url = url else { return }
        NetworkingManager.shared.loadJSONData(from: url,
                                              configuration: mainWeatherModel.configuration) { [weak self] result in
            switch result {
            case .success(let data):
                let groupDispatch = DispatchGroup()
                let data = try? JSONDecoder().decode(WeatherImages.self, from: data)
                /// Загрузка картинки в зависимости от состояния погоды
                switch self?.state {
                case "Clear", "Clouds", "Drizzle", "Haze":
                    groupDispatch.enter()
                    print("DOWNLOAD MAIN IMAGE")
                    if let image = self?.downloadImage(at: data?.homeImages[0]) {
                        self?.setMainImage(image)
                    }
                    groupDispatch.leave()
                    print("SET MAIN IMAGE")
                default:
                    groupDispatch.enter()
                    print("DOWNLOAD MAIN IMAGE")
                    if let image = self?.downloadImage(at: data?.strollImages[0]) {
                        self?.setMainImage(image)
                    }
                    groupDispatch.leave()
                    print("SET MAIN IMAGE")
                }
                groupDispatch.enter()
                print("DOWNLOAD BACKGROUND IMAGE")
                if let image = self?.downloadImage(at: data?.backgroundImage) {
                    self?.setBackgroundImage(image)
                }
                groupDispatch.leave()
                print("SET BACKGROUND IMAGE")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    private func downloadImage(at string: String?) -> UIImage? {
        guard let string = string else { return nil }
        guard let url = URL(string: string) else { return nil }
        guard let imageData = try? Data(contentsOf: url) else { return nil }
        let image = UIImage(data: imageData)
        return image
    }
    private func preapareNetworkDataToPresent() {
        let groupDispatch = DispatchGroup()
        groupDispatch.enter()
        print("STEP_1_DOWNDLOAD_TEMPERATURE")
        getWeatherInformation(at: mainWeatherModel.weatherURL)
        groupDispatch.leave()
        print("STEP_1_DONE")
        groupDispatch.enter()
        print("STEP_2_DOWNLOAD_IMAGES")
        getWeatherImages(at: mainWeatherModel.imagesURL)
        groupDispatch.leave()
        print("STEP_2_DONE")
        presentWeatherElements()
//            let alert = UIAlertController(title: "Упс, что-то пошло не по плану!",
//                                          message: "Проверьте интернет соединение на своём устройстве",
//                                          preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Продолжить", style: .cancel, handler: nil))
//            present(alert, animated: true, completion: nil)
        }
    //                                            + "\n\(error.localizedDescription)",
}
