//
//  InputInfoController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 16.08.2021.
//

import UIKit

final class InputInfoController: UIViewController {
    // MARK: - Properties
    private var petInformation: String?
    private var keyboardHeight: CGFloat?
    private let inputInfoView = InputInfoView(frame: UIScreen.main.bounds)
    // MARK: - Delegate Properties
    public weak var delegate: TransferPetInformationDelegate?
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        observerMethods()
        callBacksMethods()
        inputInfoView.setTextFieldDelegate(self)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        inputInfoView.textFieldFirstResponder()
    }
}
// MARK: - Methods
extension InputInfoController {
    private func addSubview() {
        view.addSubview(inputInfoView)
    }
}
// MARK: - CallBack Methods
extension InputInfoController {
    private func callBacksMethods() {
        inputInfoView.dismissControllerCallBack = { [weak self] in
            self?.dismissController()
        }
        inputInfoView.saveInformationCallBack = { [weak self] in
            self?.saveInformation()
        }
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
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            keyboardHeight = keyboardFrame.cgRectValue.height
            UIView.animate(withDuration: 0.1) { [weak self] in
                self?.inputInfoView.moveUp(self?.keyboardHeight ?? 0)
            }
        }
    }
    @objc private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.inputInfoView.moveDown(self?.keyboardHeight ?? 0)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
// MARK: - UITextField Delegate
extension InputInfoController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        petInformation = textField.text
    }
}
// MARK: - Actions
@objc
extension InputInfoController {
    private func dismissController() {
        dismiss(animated: true, completion: nil)
    }
    private func saveInformation() {
        if let petInformation = petInformation {
            delegate?.transferPetInformation(petInformation)
        }
        dismissController()
    }
}
// MARK: - Public Methods
extension InputInfoController {
    public func checkTextField(_ text: String?) {
        guard let text = text else { return }
        inputInfoView.textFieldValue(text)
    }
}
