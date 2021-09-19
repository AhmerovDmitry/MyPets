//
//  InputInfoView.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 20.08.2021.
//

import UIKit

final class InputInfoView: UIView {

    // MARK: - Property

    weak var delegate: DataTransferDelegate?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "Укажите информацию о питомце"
        label.textColor = UIColor.CustomColor.lightGray
        return label
    }()
    private let textFieldBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.CustomColor.lightGray
        view.clipsToBounds = true
        return view
    }()
    private let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        return textField
    }()
    private let catOutline: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "catOutline")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.CustomColor.lightGray
        return image
    }()
    private let saveButton = UIButton.createTypicalButton(title: "Сохранить",
                                                          backgroundColor: .white,
                                                          borderWidth: nil,
                                                          target: self,
                                                          action: #selector(saveInformation))
    private let cancelButton = UIButton.createTypicalButton(title: "Отменить",
                                                            backgroundColor: .white,
                                                            borderWidth: nil,
                                                            target: self,
                                                            action: #selector(dismissController))

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
        setBlurEffect(self, frame: self.frame)
        setTextFieldBackgroundViewConstraints()
        setTextFieldConstraints()
        setCatOutlineConstraints()
        setTitleLableConstraints()
        setSaveButtonConstraints()
        setCancelButtonConstraints()
    }
    private func setTitleLableConstraints() {
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: catOutline.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8)
        ])
    }
    private func setTextFieldBackgroundViewConstraints() {
        self.addSubview(textFieldBackgroundView)
        textFieldBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textFieldBackgroundView.topAnchor.constraint(equalTo: self.centerYAnchor),
            textFieldBackgroundView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.06),
            textFieldBackgroundView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            textFieldBackgroundView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    private func setTextFieldConstraints() {
        textFieldBackgroundView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: textFieldBackgroundView.topAnchor),
            textField.bottomAnchor.constraint(equalTo: textFieldBackgroundView.bottomAnchor),
            textField.leftAnchor.constraint(equalTo: textFieldBackgroundView.leftAnchor, constant: 15),
            textField.rightAnchor.constraint(equalTo: textFieldBackgroundView.rightAnchor, constant: -15)
        ])
    }
    private func setCatOutlineConstraints() {
        self.addSubview(catOutline)
        catOutline.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            catOutline.widthAnchor.constraint(equalTo: textFieldBackgroundView.widthAnchor, multiplier: 0.2),
            catOutline.heightAnchor.constraint(equalTo: catOutline.widthAnchor),
            catOutline.bottomAnchor.constraint(equalTo: textFieldBackgroundView.topAnchor),
            catOutline.leftAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    private func setSaveButtonConstraints() {
        self.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: textFieldBackgroundView.bottomAnchor, constant: 6),
            saveButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.06),
            saveButton.leftAnchor.constraint(equalTo: textFieldBackgroundView.leftAnchor),
            saveButton.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -3)
        ])
    }
    private func setCancelButtonConstraints() {
        self.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: textFieldBackgroundView.bottomAnchor, constant: 6),
            cancelButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.06),
            cancelButton.rightAnchor.constraint(equalTo: textFieldBackgroundView.rightAnchor),
            cancelButton.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 3)
        ])
    }
    private func setCornerRadiusForElements() {
        textFieldBackgroundView.layer.cornerRadius = textFieldBackgroundView.bounds.height / 2
        saveButton.layer.cornerRadius = saveButton.bounds.height / 2
        cancelButton.layer.cornerRadius = saveButton.bounds.height / 2
    }
}

// MARK: - Methods

@objc
extension InputInfoView {
    func saveInformation() {
        delegate?.transferInformation(nil)
    }
    func dismissController() {
        delegate?.dismissController()
    }
}

extension InputInfoView {
    func setTextFieldDelegate<T: UITextFieldDelegate>(_ target: T) {
        textField.delegate = target
    }
    func textFieldValue(_ text: String) {
        textField.text = text
    }
    func textFieldFirstResponder() {
        textField.becomeFirstResponder()
    }
}
