//
//  MainMenuView.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 11.08.2021.
//

import UIKit

final class MainMenuView: UIView {

    // MARK: - Property

    let weatherView = WeatherMenuView()
    private let shimmerView = ShimmerView()

    // MARK: - Init / Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private func setupUI() {
        setSelfViewUI()
        setWeatherMenuViewConstraints()
        setShimmerViewConstraints()
    }
    private func setSelfViewUI() {
        self.backgroundColor = .white
    }
    func setWeatherMenuViewConstraints() {
        self.addSubview(weatherView)
        weatherView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            weatherView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12),
            weatherView.widthAnchor.constraint(equalToConstant: UIView.ninePartsScreenMultiplier),
            weatherView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    private func setShimmerViewConstraints() {
        weatherView.addSubview(shimmerView)
        shimmerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shimmerView.centerXAnchor.constraint(equalTo: weatherView.centerXAnchor),
            shimmerView.centerYAnchor.constraint(equalTo: weatherView.centerYAnchor),
            shimmerView.heightAnchor.constraint(equalTo: weatherView.heightAnchor, multiplier: 0.2),
            shimmerView.widthAnchor.constraint(equalTo: weatherView.heightAnchor, multiplier: 0.2)
        ])
    }
}

// MARK: - Public Methods

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
