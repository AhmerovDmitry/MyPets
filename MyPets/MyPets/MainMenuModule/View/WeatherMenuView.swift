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
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Properties
    private let weatherTestImage1: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "weatherTestImage1")
        image.contentMode = .scaleAspectFill
        return image
    }()
    private let weatherTestImage2: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "weatherTestImage2")
        image.contentMode = .scaleAspectFill
        return image
    }()
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 64)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.CustomColor.dark
        label.text = "32°"
        return label
    }()
}

// MARK: - Setup UI
extension WeatherMenuView {
    private func setupUI() {
        setSelfViewUI()
        setWeatherTestImage1Constraints()
        setWeatherTestImage2Constraints()
        setTemperatureLabelConstraints()
    }
    private func setSelfViewUI() {
        self.setDefaultShadow()
        self.backgroundColor = UIColor.CustomColor.lightGray
        self.layer.cornerRadius = 16
    }
    private func setWeatherTestImage1Constraints() {
        self.addSubview(weatherTestImage1)
        weatherTestImage1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherTestImage1.heightAnchor.constraint(equalTo: self.heightAnchor),
            weatherTestImage1.widthAnchor.constraint(equalTo: self.heightAnchor),
            weatherTestImage1.topAnchor.constraint(equalTo: self.topAnchor),
            weatherTestImage1.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
    private func setWeatherTestImage2Constraints() {
        self.addSubview(weatherTestImage2)
        weatherTestImage2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherTestImage2.heightAnchor.constraint(equalTo: weatherTestImage1.heightAnchor, multiplier: 0.9),
            weatherTestImage2.widthAnchor.constraint(equalTo: weatherTestImage1.heightAnchor, multiplier: 0.9),
            weatherTestImage2.centerYAnchor.constraint(equalTo: weatherTestImage1.centerYAnchor),
            weatherTestImage2.centerXAnchor.constraint(equalTo: weatherTestImage1.centerXAnchor)
        ])
    }
    private func setTemperatureLabelConstraints() {
        self.addSubview(temperatureLabel)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: self.topAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            temperatureLabel.widthAnchor.constraint(equalTo: self.heightAnchor),
            temperatureLabel.leftAnchor.constraint(equalTo: self.leftAnchor)
        ])
    }
}
