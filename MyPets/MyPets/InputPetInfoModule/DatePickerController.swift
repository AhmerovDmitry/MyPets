//
//  DatePickerController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 17.09.2021.
//

import UIKit

final class DatePickerController: UIViewController {

    // MARK: - Property

    private var dateBirthday = Date()

    private let datePickerView: DatePickerView
    private let dateFormatter: DateFormatterService
    weak var delegate: TransferPetBirthdayDelegate?

    // MARK: - Init / Lifecycle

    init() {
        self.datePickerView = DatePickerView(frame: UIScreen.main.bounds)
        self.dateFormatter = DateFormatterServiceImpl()
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        view = datePickerView
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        datePickerView.delegate = self
    }
}

// MARK: - Methods

extension DatePickerController: DataTransferDelegate {
    func transferInformation(_ info: Any?) {
        guard let info = info as? Date else { return }
        let date = dateFormatter.dateToString(info)
        delegate?.transferPetBirthday(date)
        dismiss(animated: true, completion: nil)
    }
    func dismissController() {
        dismiss(animated: true, completion: nil)
    }
    func setDateForDatePicker() -> Date {
        return dateBirthday
    }
    func setDate(_ date: String) {
        guard let date = dateFormatter.stringToDate(date) else { return }
        dateBirthday = date
    }
}
