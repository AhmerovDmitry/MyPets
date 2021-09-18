//
//  MainMenuView.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 11.08.2021.
//

import UIKit

final class MainMenuView: UIView {
    let weatherView = WeatherMenuView()
    private let shimmerView = ShimmerView()
    private let petPhotoView = PetPhotoView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainMenuView {
    private func setupUI() {
        setSelfViewUI()
        setWeatherMenuViewConstraints()
        setShimmerViewConstraints()
        setPetPhotoViewConstraint()
    }
    private func setSelfViewUI() {
        self.backgroundColor = .white
    }
    private func setWeatherMenuViewConstraints() {
        self.addSubview(weatherView)
        weatherView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 12),
            weatherView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            weatherView.heightAnchor.constraint(equalToConstant: self.bounds.height / 6),
            weatherView.widthAnchor.constraint(equalToConstant: UIView.ninePartsScreenMultiplier)
        ])
    }
    private func setShimmerViewConstraints() {
        weatherView.addSubview(shimmerView)
        shimmerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shimmerView.centerXAnchor.constraint(equalTo: weatherView.centerXAnchor),
            shimmerView.centerYAnchor.constraint(equalTo: weatherView.centerYAnchor),
            shimmerView.heightAnchor.constraint(equalTo: weatherView.heightAnchor, multiplier: 0.7),
            shimmerView.widthAnchor.constraint(equalTo: weatherView.heightAnchor, multiplier: 0.7)
        ])
    }
    private func setPetPhotoViewConstraint() {
        self.addSubview(petPhotoView)
        petPhotoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            petPhotoView.topAnchor.constraint(equalTo: weatherView.bottomAnchor, constant: 12),
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
        weatherView.visibleWeatherElements()
    }
    func startShimmerAnimation() {
        shimmerView.isHidden = false
        shimmerView.startAnimation()
        weatherView.hiddenWeatherElements()
    }
}
