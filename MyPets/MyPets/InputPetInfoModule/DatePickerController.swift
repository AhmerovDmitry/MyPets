//
//  DatePickerController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 17.09.2021.
//

import UIKit

final class DatePickerController: UIViewController {
    private let datePickerView = DatePickerView(frame: UIScreen.main.bounds)

    let dateFormatter = DateFormatterService()
    weak var delegate: TransferPetBirthdayDelegate?

    override func loadView() {
        view = datePickerView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        callBacksMethods()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension DatePickerController {
    private func callBacksMethods() {
        datePickerView.dismissControllerCallBack = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        datePickerView.saveInformationCallBack = { [weak self] datePicker in
            guard let self = self else { return }
            self.delegate?.transferPetBirthday(self.dateFormatter.dateToString(datePicker.date))
            self.dismiss(animated: true, completion: nil)
        }
    }
    func setDate(_ date: String?) {
        guard let date = date else { return }
        datePickerView.setDate(dateFormatter.stringToDate(date))
    }
}
