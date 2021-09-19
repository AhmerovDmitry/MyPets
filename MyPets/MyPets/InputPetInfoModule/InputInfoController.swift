//
//  InputInfoController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 16.08.2021.
//

import UIKit

protocol InputInfoDelegate: AnyObject {
    func saveInformation()
}

final class InputInfoController: UIViewController {

    // MARK: - Property

    private var transferedInformation: String?
    private var keyboardHeight: CGFloat?
    private let inputInfoView = InputInfoView(frame: UIScreen.main.bounds)

    weak var delegate: TransferPetInformationDelegate?

    // MARK: - Init / Lifecycle

    override func loadView() {
        view = inputInfoView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        inputInfoView.delegate = self
        inputInfoView.setTextFieldDelegate(self)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setKeyboardObservers()
        inputInfoView.textFieldFirstResponder()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Methods

extension InputInfoController: DataTransferDelegate {
    func transferInformation(_ info: Any?) {
        delegate?.transferPetInformation(transferedInformation)
        dismiss(animated: true, completion: nil)
    }
    func dismissController() {
        dismiss(animated: true, completion: nil)
    }
}

extension InputInfoController {
    private func setKeyboardObservers() {
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(keyboardWillShow),
                                 name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide),
                                 name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            keyboardHeight = keyboardFrame.cgRectValue.height
            if view.frame.origin.y == 0 {
                view.frame.origin.y -= (keyboardHeight ?? 0) / 2
            }
        }
    }
    @objc private func keyboardWillHide(_ notification: Notification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension InputInfoController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        transferedInformation = textField.text
    }
}

extension InputInfoController {
    func checkTextField(_ text: String?) {
        guard let text = text else { return }
        inputInfoView.textFieldValue(text)
    }
}
