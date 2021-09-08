//
//  WeatherMenuView.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 27.08.2021.
//

import UIKit

final class WeatherMenuView: UIView {
    // MARK: - Initialization & Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        showLoadingAnimation()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Properties
    weak var delegate: MainMenuControllerDelegate?

    private var temperatureValue: NSAttributedString?
    private var weatherBackground: UIImage?
    private var weatherMainImage: UIImage?
    private var requestCounter = 0

    private let backgroundWeatherImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.isHidden = true
        image.layer.opacity = 0
        return image
    }()
    private let mainWeatherImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.isHidden = true
        image.layer.opacity = 0
        return image
    }()
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.CustomColor.dark
        label.isHidden = true
        label.layer.opacity = 0
        return label
    }()
    private let maskedView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.clipsToBounds = true
        return view
    }()
    private let animationImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFit
        let imagesArray: [UIImage] = [UIImage(named: "DogAnimationFrame_0") ?? UIImage(),
                                      UIImage(named: "DogAnimationFrame_1") ?? UIImage(),
                                      UIImage(named: "DogAnimationFrame_2") ?? UIImage(),
                                      UIImage(named: "DogAnimationFrame_3") ?? UIImage(),
                                      UIImage(named: "DogAnimationFrame_4") ?? UIImage(),
                                      UIImage(named: "DogAnimationFrame_5") ?? UIImage(),
                                      UIImage(named: "DogAnimationFrame_6") ?? UIImage(),
                                      UIImage(named: "DogAnimationFrame_7") ?? UIImage(),
                                      UIImage(named: "DogAnimationFrame_8") ?? UIImage()]
        image.animationImages = imagesArray
        image.animationDuration = 1
        image.animationRepeatCount = .max
        image.startAnimating()
        return image
    }()
    private var rightAnimationViewConstraint = NSLayoutConstraint()
}
// MARK: - Setup UI
extension WeatherMenuView {
    private func setupUI() {
        setSelfViewUI()
        setBackgroundImageConstraints()
        setMainImageConstraints()
        setTemperatureLabelConstraints()
        setMaskViewConstraints()
        setLoadingAnimationConstraints()
    }
    private func setSelfViewUI() {
        self.setDefaultShadow()
        self.backgroundColor = UIColor.CustomColor.lightGray
        self.layer.cornerRadius = 16
    }
    private func setBackgroundImageConstraints() {
        self.addSubview(backgroundWeatherImage)
        backgroundWeatherImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundWeatherImage.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundWeatherImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundWeatherImage.leftAnchor.constraint(equalTo: self.centerXAnchor),
            backgroundWeatherImage.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
    private func setMainImageConstraints() {
        self.addSubview(mainWeatherImage)
        mainWeatherImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainWeatherImage.heightAnchor.constraint(equalTo: backgroundWeatherImage.heightAnchor, multiplier: 0.8),
            mainWeatherImage.widthAnchor.constraint(equalTo: backgroundWeatherImage.heightAnchor, multiplier: 0.8),
            mainWeatherImage.centerYAnchor.constraint(equalTo: backgroundWeatherImage.centerYAnchor),
            mainWeatherImage.centerXAnchor.constraint(equalTo: backgroundWeatherImage.centerXAnchor)
        ])
    }
    private func setTemperatureLabelConstraints() {
        self.addSubview(temperatureLabel)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: self.topAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            temperatureLabel.rightAnchor.constraint(equalTo: self.centerXAnchor),
            temperatureLabel.leftAnchor.constraint(equalTo: self.leftAnchor)
        ])
    }
    private func setMaskViewConstraints() {
        self.addSubview(maskedView)
        maskedView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            maskedView.heightAnchor.constraint(equalTo: self.heightAnchor),
            maskedView.widthAnchor.constraint(equalTo: self.widthAnchor),
            maskedView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            maskedView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    private func setLoadingAnimationConstraints() {
        maskedView.addSubview(animationImage)
        animationImage.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            animationImage.heightAnchor.constraint(equalTo: maskedView.heightAnchor, multiplier: 0.7),
            animationImage.widthAnchor.constraint(equalTo: maskedView.heightAnchor, multiplier: 0.7),
            animationImage.centerYAnchor.constraint(equalTo: maskedView.centerYAnchor),
            animationImage.centerXAnchor.constraint(equalTo: maskedView.centerXAnchor)
        ])
    }
}
// MARK: - Methods
extension WeatherMenuView {
    /// Метод обрабатывающий показания погоды,
    /// добавляет визальный эффект тексту, цифры погоды имеют атрибут bold, а знак градусов ultraLight,
    /// возможна замена символа градусов с "°" на "℃"
    private func changeTextAttribute(_ text: String) -> NSAttributedString {
        let degreeSymbol = NSMutableAttributedString(string: "℃")
        let attrString = NSMutableAttributedString(string: text)
        let attributes0 = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 64, weight: .bold)]
        let attributes1 = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 64, weight: .ultraLight)]
        attrString.addAttributes(attributes0, range: NSRange(location: 0, length: attrString.string.count))
        degreeSymbol.addAttributes(attributes1, range: NSRange(location: 0, length: 1))
        let resultString = attrString
        resultString.append(degreeSymbol)
        return resultString
    }
    /// Метод останавливает анимацию после загрузки данных из сети
    private func stopAnimation() {
        animationImage.stopAnimating()
        animationImage.removeFromSuperview()
        maskedView.removeFromSuperview()
    }
    /// Плавное появление обновленных элементов
    private func presentWeatherElements() {
        backgroundWeatherImage.isHidden = false
        mainWeatherImage.isHidden = false
        temperatureLabel.isHidden = false
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.backgroundWeatherImage.layer.opacity = 1
            self?.mainWeatherImage.layer.opacity = 1
            self?.temperatureLabel.layer.opacity = 1
        }
    }
    /// Анимация персонажа на вью во время загрузки данных из сети
    private func showLoadingAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self = self else { return }

            if self.temperatureValue != nil && self.weatherBackground != nil && self.weatherMainImage != nil {
                self.temperatureLabel.attributedText = self.temperatureValue
                self.backgroundWeatherImage.image = self.weatherBackground
                self.mainWeatherImage.image = self.weatherMainImage

                self.stopAnimation()
                self.presentWeatherElements()
            } else if self.temperatureValue == nil ||
                        self.weatherBackground == nil ||
                        self.weatherMainImage == nil {
                if self.requestCounter <= 5 {
                    self.requestCounter += 1
                    self.showLoadingAnimation()
                } else {
                    self.delegate?.presentAlertWithRequestError()
                    self.requestCounter = 0
                    self.stopAnimation()
                }
            }
        }
    }
}
// MARK: - Public Methods
extension WeatherMenuView {
    /// Методы обрабатывающие данные из сети и
    /// присваивающие эти данные промежуточным переменным
    func setupTemperatureLabel(value: Int) {
        temperatureValue = changeTextAttribute("\(value)")
    }
    func setupBackgroundImage(_ image: UIImage) {
        weatherBackground = image
    }
    func setupMainImage(_ image: UIImage) {
        weatherMainImage = image
    }
}
