//
//  InputInfoController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 16.08.2021.
//

import UIKit

final class InputInfoController: UIViewController {
    // MARK: - Properties
    private var keyboardHeight: CGFloat?
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
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        textField.delegate = self
        observerMethods()
        setBackgroundViewConstraints()
        setTextFieldBackgroundViewConstraints()
        setTextFieldConstraints()
        setHandOutlineConstraints()
        setCatOutlineConstraints()
        setDogOutlineConstraints()
        setTitleLableConstraints()
    }
}
    
// MARK: - Methods
extension InputInfoController {
    private func setBackgroundViewConstraints() {
        view.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    private func setTitleLableConstraints() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: catOutline.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }
    private func setTextFieldBackgroundViewConstraints() {
        view.addSubview(textFieldBackgroundView)
        textFieldBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textFieldBackgroundView.topAnchor.constraint(equalTo: view.centerYAnchor),
            textFieldBackgroundView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06),
            textFieldBackgroundView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            textFieldBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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
        view.addSubview(handOutline)
        handOutline.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            handOutline.heightAnchor.constraint(equalTo: textFieldBackgroundView.heightAnchor, multiplier: 0.5),
            handOutline.widthAnchor.constraint(equalTo: handOutline.heightAnchor),
            handOutline.topAnchor.constraint(equalTo: textFieldBackgroundView.bottomAnchor),
            handOutline.rightAnchor.constraint(equalTo: textFieldBackgroundView.rightAnchor)
        ])
    }
    private func setCatOutlineConstraints() {
        view.addSubview(catOutline)
        catOutline.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            catOutline.widthAnchor.constraint(equalTo: textFieldBackgroundView.widthAnchor, multiplier: 0.2),
            catOutline.heightAnchor.constraint(equalTo: catOutline.widthAnchor),
            catOutline.bottomAnchor.constraint(equalTo: textFieldBackgroundView.topAnchor),
            catOutline.leftAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    private func setDogOutlineConstraints() {
        view.addSubview(dogOutline)
        dogOutline.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dogOutline.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            dogOutline.heightAnchor.constraint(equalTo: dogOutline.widthAnchor),
            dogOutline.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dogOutline.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
    }
}

// MARK: - Keyboard Methods
extension InputInfoController {
    private func observerMethods() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil
        )
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil
        )
    }
    @objc private func keyboardWillShow(_ notification: Notification) {
        if view.frame.origin.y == 0 {
            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                keyboardHeight = keyboardFrame.cgRectValue.height
                UIView.animate(withDuration: 0.1) { [weak self] in
                    self?.view.frame.origin.y -= self?.keyboardHeight ?? 0
                    [self?.titleLabel, self?.catOutline, self?.textFieldBackgroundView, self?.handOutline].forEach {
                        $0?.frame.origin.y += self?.dogOutline.frame.height ?? 0
                    }
                }
            }
        }
    }
    @objc private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.1) { [weak self] in
            [self?.titleLabel, self?.catOutline, self?.textFieldBackgroundView, self?.handOutline].forEach {
                $0?.frame.origin.y -= self?.dogOutline.frame.height ?? 0
            }
            self?.view.frame.origin.y = 0
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: - Delegate
extension InputInfoController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        return true
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print(textField.text)
    }
}
