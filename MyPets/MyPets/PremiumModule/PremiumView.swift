//
//  PremiumView.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 08.08.2021.
//

import UIKit

final class PremiumView: UIView {
    var presentControllerCallBack: (() -> Void)?
    var dismissControllerCallBack: (() -> Void)?
    private var premiumText: [String]?
    private let cellID = "PremiumCellId"
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 32
        stackView.setCustomSpacing(24, after: titleStackView)
        stackView.setCustomSpacing(4, after: priceLabel)
        return stackView
    }()
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.alpha = 0.7
        button.setImage(UIImage(named: "closeButton"), for: .normal)
        button.tintColor = .white
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.addTarget(self, action: #selector(closeController), for: .touchUpInside)
        return button
    }()
    private let titleLogo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "crownIcon")
        image.contentMode = .scaleAspectFit
        return image
    }()
    private let titleText: UILabel = {
        let label = UILabel()
        label.text = "MyPets Premium"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private lazy var premiumTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.isScrollEnabled = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.backgroundColor = .clear
        tableView.separatorColor = .white
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "149 ₽"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 48, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let priceDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Навсегда и без ограничений"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let buyButton = TypicalProjectButtonBuilder()
        .with(title: "Получить Premium")
        .with(titleColor: UIColor.CustomColor.purple)
        .with(font: UIFont.systemFont(ofSize: 17, weight: .regular))
        .with(backgroundColor: .white)
        .with(adjustsFontSizeToFitWidth: true)
        .with(self, action: #selector(closeControllerWithPurchase))
        .build()
}

extension PremiumView {
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
        self.setGradientEffect(
            self,
            colorOne: UIColor.PurpleGradientColor.darkPurple,
            colorTwo: UIColor.PurpleGradientColor.lightPurple,
            startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1)
        )
    }
    private func setupUI() {
        self.backgroundColor = .white
        setCloseButtonConstraints()
        setMainStackViewConstraints()
        setTitleStackViewConstraints()
        setPremiumTableViewConstraints()
        setPriceLabelsConstraints()
        setBuyButtonConstraints()
    }
    private func setCloseButtonConstraints() {
        self.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.04),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor),
            closeButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -UIScreen.main.bounds.width / 25),
            closeButton.topAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.topAnchor, constant: UIScreen.main.bounds.width / 25
            )
        ])
    }
    private func setMainStackViewConstraints() {
        self.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.widthAnchor.constraint(equalToConstant: self.bounds.width / 1.2),
            mainStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -32),
            mainStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    private func setTitleStackViewConstraints() {
        [titleLogo, titleText].forEach { titleStackView.addArrangedSubview($0) }
        [titleLogo, titleText, titleStackView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        mainStackView.addArrangedSubview(titleStackView)
    }
    private func setPremiumTableViewConstraints() {
        mainStackView.addArrangedSubview(premiumTableView)
        premiumTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            premiumTableView.leftAnchor.constraint(equalTo: mainStackView.leftAnchor),
            premiumTableView.rightAnchor.constraint(equalTo: mainStackView.rightAnchor),
            premiumTableView.heightAnchor.constraint(equalToConstant: self.bounds.height / 3)
        ])
    }
    private func setPriceLabelsConstraints() {
        [priceLabel, priceDescriptionLabel].forEach {
            mainStackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    private func setBuyButtonConstraints() {
        self.addSubview(buyButton)
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        buyButton.layer.cornerRadius = buyButton.bounds.height / 2
        NSLayoutConstraint.activate([
            buyButton.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 32),
            buyButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.06),
            buyButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            buyButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}

extension PremiumView {
    @objc func closeController() {
        dismissControllerCallBack?()
    }
    @objc func closeControllerWithPurchase() {
        presentControllerCallBack?()
    }
    func getPremiumContent(_ content: PremiumModelProtocol) {
        premiumText = content.description
    }
}

extension PremiumView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return premiumText?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .white
        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.text = premiumText?[indexPath.row].description
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = tableView.frame.size.height / 5
        return cellHeight
    }
}
