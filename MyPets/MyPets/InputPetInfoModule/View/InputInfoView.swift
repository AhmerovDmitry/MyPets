//
//  InputInfoView.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 20.08.2021.
//

import UIKit

final class InputInfoView: UIView {
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
    public var saveInformationCallBack: (() -> Void)?
    public var dismissControllerCallBack: (() -> Void)?
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
    private let backgroundView: UIView = {
        let view = UIView()
        view.setBlurEffect(view, frame: UIScreen.main.bounds)
        return view
    }()
    private let textFieldBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.CustomColor.lightGray
        view.clipsToBounds = true
        view.layer.cornerRadius = UIScreen.main.bounds.height * 0.06 / 2
        return view
    }()
    private let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        return textField
    }()
    private let handOutline: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "handTapOutline")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.CustomColor.lightGray
        image.alpha = 0.5
        return image
    }()
    private let catOutline: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "catOutline")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.CustomColor.lightGray
        return image
    }()
    private let dogOutline: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "dogOutline")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.CustomColor.lightGray
        return image
    }()
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сохранить", for: .normal)
        button.tintColor = UIColor.CustomColor.lightGray
        button.addTarget(self, action: #selector(saveInformation), for: .touchUpInside)
        return button
    }()
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отменить", for: .normal)
        button.tintColor = .red
        button.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        return button
    }()
    /// Клавиатура при открытии вызывает метод keyboardWillShow
    /// когда начинаешь что-то писать в UITextField метод срабатывает повторно
    /// для этого завел фантомную вью, которая будет как дополнительное условие анимации
    private lazy var viewForKeyboardFix = UIView(frame: self.frame)
}

// MARK: - Setup UI
extension InputInfoView {
    private func setupUI() {
        self.backgroundColor = .clear
        setBackgroundViewConstraints()
        setTextFieldBackgroundViewConstraints()
        setTextFieldConstraints()
        setHandOutlineConstraints()
        setCatOutlineConstraints()
        setDogOutlineConstraints()
        setTitleLableConstraints()
        setSaveButtonConstraints()
        setCancelButtonConstraints()
    }
    private func setBackgroundViewConstraints() {
        self.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundView.leftAnchor.constraint(equalTo: self.leftAnchor),
            backgroundView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
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
    private func setHandOutlineConstraints() {
        self.addSubview(handOutline)
        handOutline.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            handOutline.heightAnchor.constraint(equalTo: textFieldBackgroundView.heightAnchor, multiplier: 0.5),
            handOutline.widthAnchor.constraint(equalTo: handOutline.heightAnchor),
            handOutline.topAnchor.constraint(equalTo: textFieldBackgroundView.bottomAnchor),
            handOutline.rightAnchor.constraint(equalTo: textFieldBackgroundView.rightAnchor)
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
    private func setDogOutlineConstraints() {
        self.addSubview(dogOutline)
        dogOutline.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dogOutline.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            dogOutline.heightAnchor.constraint(equalTo: dogOutline.widthAnchor),
            dogOutline.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            dogOutline.leftAnchor.constraint(equalTo: self.leftAnchor)
        ])
    }
    private func setSaveButtonConstraints() {
        self.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: handOutline.bottomAnchor),
            saveButton.leftAnchor.constraint(equalTo: textFieldBackgroundView.leftAnchor)
        ])
    }
    private func setCancelButtonConstraints() {
        self.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: handOutline.bottomAnchor),
            cancelButton.rightAnchor.constraint(equalTo: textFieldBackgroundView.rightAnchor)
        ])
    }
}

// MARK: - Actions
@objc
extension InputInfoView {
    private func saveInformation() {
        saveInformationCallBack?()
    }
    private func dismissController() {
        dismissControllerCallBack?()
    }
}

// MARK: - Public Methods
extension InputInfoView {
    public func setTextFieldDelegate<T: UITextFieldDelegate>(_ target: T) {
        textField.delegate = target
    }
    public func moveUp(_ point: CGFloat) {
        if viewForKeyboardFix.frame.origin.y == 0 {
            viewForKeyboardFix.frame.origin.y += 1
            dogOutline.frame.origin.y -= point
            [titleLabel, catOutline, textFieldBackgroundView, handOutline, saveButton, cancelButton].forEach {
                $0.frame.origin.y -= dogOutline.frame.height
            }
        }
    }
    public func moveDown(_ point: CGFloat) {
        viewForKeyboardFix.frame.origin.y = 0
        dogOutline.frame.origin.y += point
        [titleLabel, catOutline, textFieldBackgroundView, handOutline, saveButton, cancelButton].forEach {
            $0.frame.origin.y += dogOutline.frame.height
        }
    }
}
