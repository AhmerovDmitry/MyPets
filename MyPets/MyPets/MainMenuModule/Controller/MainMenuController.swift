//
//  MainMenuController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 11.08.2021.
//

import UIKit

protocol MainMenuControllerDelegate: AnyObject {
    func presentAlertWithRequestError()
}

final class MainMenuController: UIViewController {
    // MARK: - Properties
    private let networkService: NetworkServiceProtocol
    private var state: String?

    // MARK: - View & Model
    private let mainWeatherModel = MainWeatherModel()
    private let mainMenuView = MainMenuView(frame: UIScreen.main.bounds)

    // MARK: - Initialization
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mainMenuView.setWeatherViewDelegate(self)
        getWeatherInformation(at: mainWeatherModel.weatherURL)
        getWeatherImages(at: mainWeatherModel.imagesURL)
        setupNavigationController()
        addSubview()
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
}
// MARK: - Network Methods
/// Методы работы с сетью
extension MainMenuController {
    private func getWeatherInformation(at url: URL?) {
        guard let url = url else { return }

        networkService.loadJSONData(from: url, httpAdditionalHeaders: nil,
                                    decodeModel: WeatherDescription.self) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    guard let temp = data.main.temp else { return }
                    self?.setWeatherTitle(Int(round(temp)))
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    private func getWeatherImages(at url: URL?) {
        guard let url = url else { return }

        networkService.loadJSONData(from: url, httpAdditionalHeaders: mainWeatherModel.httpAdditionalHeaders,
                                    decodeModel: WeatherImages.self) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    guard let backgroundImage = self?.downloadImage(at: data.backgroundImage) else { return }
                    self?.setBackgroundImage(backgroundImage)
                    guard let mainImage = self?.downloadImage(at: data.homeImages[0]) else { return }
                    self?.setMainImage(mainImage)
                }
            case .failure(let error):
                print(error)
            }
        }
//        NetworkingManager.shared.loadJSONData(from: url,
//                                              configuration: mainWeatherModel.configuration) { [weak self] result in
//            switch result {
//            case .success(let data):
//                let data = try? JSONDecoder().decode(WeatherImages.self, from: data)
//                var randomIndex = Int()
//                switch self?.state {
//                case "Clear", "Clouds", "Drizzle", "Haze":
//                    if let image = self?.downloadImage(at: data?.strollImages[0]) {
//                        self?.mainImage = image
////                        self?.setMainImage(image)
//                    }
//                default:
//                    if let image = self?.downloadImage(at: data?.homeImages[0]) {
//                        self?.mainImage = image
////                        self?.setMainImage(image)
//                    }
//                }
//                if let image = self?.downloadImage(at: data?.backgroundImage) {
//                    self?.backgroundImage = image
////                    self?.setBackgroundImage(image)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
    private func downloadImage(at string: String?) -> UIImage? {
        guard let string = string else { return nil }
        guard let url = URL(string: string) else { return nil }
        guard let imageData = try? Data(contentsOf: url) else { return nil }
        let image = UIImage(data: imageData)
        return image
    }
}
// MARK: - Delegate Methods
extension MainMenuController: MainMenuControllerDelegate {
    func presentAlertWithRequestError() {
        let alert = UIAlertController(title: "Упс, что-то пошло не по плану!",
                                      message: "Проверьте интернет соединение на своём устройстве",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Продолжить", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
