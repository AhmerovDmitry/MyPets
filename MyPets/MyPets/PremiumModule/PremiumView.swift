//
//  PremiumView.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 08.08.2021.
//

import UIKit

final class PremiumView: UIView {

    // MARK: - Property

    weak var delegate: PremiumControllerDelegate?

    let cellID = "PremiumCellId"

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
    private let buyButton = UIButton.createTypicalButton(title: "Получить Premium",
                                                         backgroundColor: .white,
                                                         borderWidth: nil,
                                                         target: self,
                                                         action: #selector(closeControllerWithPurchase))

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
        setSelfViewUI()
        setCloseButtonConstraints()
        setMainStackViewConstraints()
        setTitleStackViewConstraints()
        setPremiumTableViewConstraints()
        setPriceLabelsConstraints()
        setBuyButtonConstraints()
    }
    private func setSelfViewUI() {
        self.backgroundColor = .white
        self.setGradientEffect(self, colorOne: UIColor.PurpleGradientColor.darkPurple,
                               colorTwo: UIColor.PurpleGradientColor.lightPurple,
                               startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1))
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
        NSLayoutConstraint.activate([
            buyButton.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 32),
            buyButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.06),
            buyButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            buyButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    private func setCornerRadiusForElements() {
        buyButton.layer.cornerRadius = buyButton.bounds.height / 2
    }
}

// MARK: - Methods

extension PremiumView {
    @objc private func closeController() {
        delegate?.dismissController(withPurchase: false)
    }
    @objc private func closeControllerWithPurchase() {
        delegate?.dismissController(withPurchase: true)
    }
    func tableViewDelegateAndDataSource<T>(_ target: T) where T: UITableViewDelegate,
                                                                      T: UITableViewDataSource {
        premiumTableView.delegate = target
        premiumTableView.dataSource = target
    }
}
