//
//  WeatherMenuView.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 27.08.2021.
//

import UIKit

final class WeatherMenuView: UIView {
    private let reloadWeatherButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "goforward"), for: .normal)
        button.tintColor = UIColor.CustomColor.darkGray
        return button
    }()
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
        return image
    }()
}

// MARK: - Setup UI
extension WeatherMenuView {
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    private func setupUI() {
        setSelfViewUI()
        setBackgroundImageConstraints()
        setMainImageConstraints()
        setTemperatureLabelConstraints()
        setLoadingAnimationConstraints()
        setReloadWeatherButtonConstraints()
    }
    private func setSelfViewUI() {
        self.setDefaultShadow()
        self.backgroundColor = UIColor.CustomColor.lightGray
        self.layer.cornerRadius = UIView.basicCornerRadius
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
    private func setLoadingAnimationConstraints() {
        self.addSubview(animationImage)
        animationImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
            animationImage.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
            animationImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            animationImage.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    private func setReloadWeatherButtonConstraints() {
        self.addSubview(reloadWeatherButton)
        reloadWeatherButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reloadWeatherButton.topAnchor.constraint(equalTo: self.topAnchor),
            reloadWeatherButton.rightAnchor.constraint(equalTo: self.rightAnchor),
            reloadWeatherButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            reloadWeatherButton.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2)
        ])
    }
}

// MARK: - Methods
extension WeatherMenuView {
    /// Метод обрабатывающий показания погоды,
    /// добавляет визальный эффект тексту, цифры погоды имеют атрибут bold, а знак градусов ultraLight,
    /// возможна замена символа градусов "°" - "℃"
    /// - Parameter text: Обрабатываемый текст
    /// - Returns: Отредактированный текст
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
}

extension WeatherMenuView {
    func setupTemperatureLabel(value: String) {
        temperatureLabel.attributedText = changeTextAttribute(value)
    }
    func setupMainImage(_ image: UIImage) {
        mainWeatherImage.image = image
    }
    func setupBackgroundImage(_ image: UIImage) {
        backgroundWeatherImage.image = image
    }
    func setupDefaultElements() {
        guard let mainImage = UIImage(named: "networkError") else { return }
        setupTemperatureLabel(value: "--")
        setupMainImage(mainImage)
        presentWeatherElements()
    }
    func removeDefaultElements() {
        backgroundWeatherImage.isHidden = true
        mainWeatherImage.isHidden = true
        temperatureLabel.isHidden = true
    }
    func startAnimation() {
        animationImage.startAnimating()
        animationImage.isHidden = false
    }
    func stopAnimation() {
        animationImage.stopAnimating()
        animationImage.isHidden = true
    }
    func presentWeatherElements() {
        backgroundWeatherImage.isHidden = false
        mainWeatherImage.isHidden = false
        temperatureLabel.isHidden = false
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.backgroundWeatherImage.layer.opacity = 1
            self?.mainWeatherImage.layer.opacity = 1
            self?.temperatureLabel.layer.opacity = 1
        }
    }
    func removeElements() {
        temperatureLabel.attributedText = nil
        mainWeatherImage.image = nil
        backgroundWeatherImage.image = nil
    }
    func reloadWeatherButtonAction(_ target: UIViewController, _ action: Selector) {
        reloadWeatherButton.addTarget(target, action: action, for: .touchUpInside)
    }
}
