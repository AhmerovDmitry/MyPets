//
//  CustomTabBarView.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 07.10.2021.
//

import UIKit

final class CustomTabBarView: UIView {

    // MARK: - Property

    private let customBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
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
        super.layoutSubviews()
        setCornerRadiusForElements()
    }

    private func setupUI() {
        setCustomBackgroundViewConstraints()
    }
    private func setCustomBackgroundViewConstraints() {
        self.addSubview(customBackgroundView)
        customBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customBackgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            customBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            customBackgroundView.leftAnchor.constraint(equalTo: self.leftAnchor),
            customBackgroundView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
    private func setCornerRadiusForElements() {
        customBackgroundView.setDefaultShadow()
    }
}
