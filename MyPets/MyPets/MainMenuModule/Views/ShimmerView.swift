//
//  ShimmerView.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 15.09.2021.
//

import UIKit

final class ShimmerView: UIView {

    // MARK: - Property

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
        self.addSubview(animationImage)
        animationImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationImage.topAnchor.constraint(equalTo: self.topAnchor),
            animationImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            animationImage.leftAnchor.constraint(equalTo: self.leftAnchor),
            animationImage.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }

    // MARK: - Methods

    func startAnimation() {
        animationImage.isHidden = false
        animationImage.startAnimating()
    }
    func stopAnimation() {
        animationImage.isHidden = true
        animationImage.stopAnimating()
    }
}
