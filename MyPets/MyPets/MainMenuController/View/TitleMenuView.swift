//
//  TitleMenuView.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 11.08.2021.
//

import UIKit

final class TitleMenuView: UIView {
    // MARK: - Initialization & Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Properties
    private let backgroundImageView = UIImageView(image: UIImage(named: "mainMenuTitleViewImage"))
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.text = "Расскажите нам о своём питомце"
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.text = "А мы будем давать советы по уходу и кормлению"
        return label
    }()
}

// MARK: - Setup UI
extension TitleMenuView {
    private func setupUI() {
        setSelfViewUI()
        setBackgroundImageViewConstraints()
        setTitleLabelConstraints()
        setDescriptionLabelConstraints()
    }
    private func setSelfViewUI() {
        self.backgroundColor = UIColor(red: 230 / 255, green: 230 / 255, blue: 240 / 255, alpha: 1)
        self.layer.cornerRadius = 16
    }
    private func setBackgroundImageViewConstraints() {
        self.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            backgroundImageView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            backgroundImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            backgroundImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    private func setTitleLabelConstraints() {
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -4),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: backgroundImageView.leftAnchor, constant: -8)
        ])
    }
    private func setDescriptionLabelConstraints() {
        self.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 4),
            descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            descriptionLabel.rightAnchor.constraint(equalTo: backgroundImageView.leftAnchor, constant: -8)
        ])
    }
}
