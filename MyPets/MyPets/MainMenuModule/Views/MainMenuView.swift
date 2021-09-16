//
//  MainMenuView.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 11.08.2021.
//

import UIKit

final class MainMenuView: UIView {
    let weatherMenuView = WeatherMenuView()
    private let shimmerView = ShimmerView()
    private let petPhotoView = PetPhotoView()
}

extension MainMenuView {
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    private func setupUI() {
        self.backgroundColor = .white
        setWeatherMenuViewConstraints()
        setShimmerViewConstraints()
        setPetPhotoViewConstraint()
    }
    private func setWeatherMenuViewConstraints() {
        self.addSubview(weatherMenuView)
        weatherMenuView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherMenuView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 12),
            weatherMenuView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            weatherMenuView.heightAnchor.constraint(equalToConstant: self.bounds.height / 6),
            weatherMenuView.widthAnchor.constraint(equalToConstant: UIView.ninePartsScreenMultiplier)
        ])
    }
    private func setShimmerViewConstraints() {
        weatherMenuView.addSubview(shimmerView)
        shimmerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shimmerView.centerXAnchor.constraint(equalTo: weatherMenuView.centerXAnchor),
            shimmerView.centerYAnchor.constraint(equalTo: weatherMenuView.centerYAnchor),
            shimmerView.heightAnchor.constraint(equalTo: weatherMenuView.heightAnchor, multiplier: 0.7),
            shimmerView.widthAnchor.constraint(equalTo: weatherMenuView.heightAnchor, multiplier: 0.7)
        ])
    }
    private func setPetPhotoViewConstraint() {
        self.addSubview(petPhotoView)
        petPhotoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            petPhotoView.topAnchor.constraint(equalTo: weatherMenuView.bottomAnchor, constant: 12),
            petPhotoView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            petPhotoView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            petPhotoView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
}

extension MainMenuView {
    func stopShimmerAnimation() {
        shimmerView.isHidden = true
        shimmerView.stopAnimation()
        weatherMenuView.visibleWeatherElements()
    }
    func startShimmerAnimation() {
        shimmerView.isHidden = false
        shimmerView.startAnimation()
        weatherMenuView.hiddenWeatherElements()
    }
}
