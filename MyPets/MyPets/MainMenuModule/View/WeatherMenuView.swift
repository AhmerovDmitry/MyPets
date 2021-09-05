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
        moveAnimation()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Properties
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.isHidden = true
        image.layer.opacity = 0
        return image
    }()
    private let mainImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
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
        image.contentMode = .scaleAspectFill
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
        self.addSubview(backgroundImage)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImage.heightAnchor.constraint(equalTo: self.heightAnchor),
            backgroundImage.widthAnchor.constraint(equalTo: self.heightAnchor),
            backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
    private func setMainImageConstraints() {
        self.addSubview(mainImage)
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainImage.heightAnchor.constraint(equalTo: backgroundImage.heightAnchor, multiplier: 0.8),
            mainImage.widthAnchor.constraint(equalTo: backgroundImage.heightAnchor, multiplier: 0.8),
            mainImage.centerYAnchor.constraint(equalTo: backgroundImage.centerYAnchor),
            mainImage.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor)
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
            animationImage.centerYAnchor.constraint(equalTo: maskedView.centerYAnchor)
        ])
        rightAnimationViewConstraint = animationImage.rightAnchor.constraint(equalTo: maskedView.leftAnchor)
        rightAnimationViewConstraint.isActive = true
    }
}
// MARK: - Methods
extension WeatherMenuView {
    /// Метод обрабатывающий показания погоды,
    /// добавляет визальный эффект тексту, цифры погоды имеют атрибут bold, а знак градусов ultraLight,
    /// возможна замена символа градусов с "°" на "℃"
    private func changeTextAttribute(_ text: String) -> NSAttributedString {
        let degreeSymbol = NSMutableAttributedString(string: "°")
        let attrString = NSMutableAttributedString(string: text)
        let attributes0 = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 64, weight: .bold)]
        let attributes1 = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 64, weight: .ultraLight)]
        attrString.addAttributes(attributes0, range: NSRange(location: 0, length: attrString.string.count))
        degreeSymbol.addAttributes(attributes1, range: NSRange(location: 0, length: 1))
        let resultString = attrString
        resultString.append(degreeSymbol)
        return resultString
    }
    /// Анимация персонажа пробегающего по вью во время загрузки данных из сети
    private func moveAnimation() {
        rightAnimationViewConstraint.constant += UIScreen.main.bounds.width * 1.2
        UIView.animate(withDuration: 5, delay: 0, options: [.repeat, .curveLinear], animations: { [weak self] in
            self?.layoutIfNeeded()
        })
    }
}
// MARK: - Public Methods
extension WeatherMenuView {
    /// Методы обрабатывающие данные из сети и
    /// присваивающие эти данные изображениям и лейблам
    public func setupTemperatureLabel(value: Int) {
        temperatureLabel.attributedText = changeTextAttribute("\(value)")
    }
    public func setupBackgroundImage(_ image: UIImage) {
        backgroundImage.image = image
    }
    public func setupMainImage(_ image: UIImage) {
        mainImage.image = image
    }
    /// Метод останавливает анимацию после загрузки данных из сети
    public func stopAnimation() {
        animationImage.stopAnimating()
        animationImage.removeFromSuperview()
    }
    /// Плавное появление обновленных элементов
    public func presentWeatherElements() {
        backgroundImage.isHidden = false
        mainImage.isHidden = false
        temperatureLabel.isHidden = false
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.backgroundImage.layer.opacity = 1
            self?.mainImage.layer.opacity = 1
            self?.temperatureLabel.layer.opacity = 1
        }
    }
}
