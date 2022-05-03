//
//  WeatherMenuView.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 27.08.2021.
//

import UIKit

final class WeatherMenuView: UIView {

    // MARK: - Property

    private let backgroundWeatherImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    private let mainWeatherImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.CustomColor.dark
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 18, weight: .ultraLight)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.CustomColor.dark
        return label
    }()

    // MARK: - Init / Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    override func layoutSubviews() {
        setSelfViewUI()
    }

    private func setupUI() {
        setBackgroundImageConstraints()
        setMainImageConstraints()
        setTemperatureLabelConstraints()
        setCityLabelConstraints()
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
            backgroundWeatherImage.widthAnchor.constraint(equalTo: self.widthAnchor),
            backgroundWeatherImage.heightAnchor.constraint(equalTo: self.widthAnchor),
            backgroundWeatherImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            backgroundWeatherImage.bottomAnchor.constraint(equalTo: self.bottomAnchor)
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
            temperatureLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            temperatureLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            temperatureLabel.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2)
        ])
    }
    private func setCityLabelConstraints() {
        self.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor),
            descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            descriptionLabel.heightAnchor.constraint(equalTo: temperatureLabel.heightAnchor, multiplier: 0.5)
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

// MARK: - Public Methods

extension WeatherMenuView {

    /// Метод обновляющий эллементы вью
    /// - Parameters:
    ///   - temp: Температура в строке, изменяется в NSAttributedString
    ///   - mainImage: Главное изображение
    ///   - backgroundImage: Бекграунд изображение

    func presentWeatherElements(temp: String?, city: String?, mainImage: UIImage?, bgImage: UIImage?) {
        temperatureLabel.attributedText = changeTextAttribute(temp ?? "--")
        descriptionLabel.text = city ?? "--"
        mainWeatherImage.image = mainImage ?? UIImage(named: "networkError")
        backgroundWeatherImage.image = bgImage ?? UIImage()
    }
    func hiddenWeatherElements() {
        temperatureLabel.isHidden = true
        descriptionLabel.isHidden = true
        mainWeatherImage.isHidden = true
        backgroundWeatherImage.isHidden = true
    }
    func visibleWeatherElements() {
        temperatureLabel.isHidden = false
        descriptionLabel.isHidden = false
        mainWeatherImage.isHidden = false
        backgroundWeatherImage.isHidden = false
    }
}
