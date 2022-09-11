//
//  DatePickerView.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 17.09.2021.
//

import UIKit

final class DatePickerView: UIView {

    // MARK: - Property

    weak var delegate: DataTransferDelegate?

    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.setDefaultShadow()
        picker.date = Date()
        picker.datePickerMode = .date
        picker.layer.cornerRadius = UIView.basicCornerRadius
        picker.layer.masksToBounds = true
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels
            picker.backgroundColor = UIColor.CustomColor.lightGray
        } else {
            picker.backgroundColor = UIColor.CustomColor.lightGray
        }
        return picker
    }()
    private let dogOutline: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "dogOutline")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.CustomColor.lightGray
        return image
    }()
	private lazy var saveButton = UIButton.createTypicalButton(title: "Сохранить",
															   backgroundColor: .white,
															   borderWidth: nil,
															   target: self,
															   action: #selector(saveInformation))
	private lazy var cancelButton = UIButton.createTypicalButton(title: "Отменить",
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
        datePicker.date = delegate?.setDateForDatePicker() ?? Date()
    }

    private func setupUI() {
        setBlurEffect(self, frame: self.frame)
        setDatePickerConstraints()
        setDogOutlineConstraints()
        setSaveButtonConstraints()
        setCancelButtonConstraints()
    }
    private func setDatePickerConstraints() {
        self.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            datePicker.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    private func setDogOutlineConstraints() {
            self.addSubview(dogOutline)
            dogOutline.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                dogOutline.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
                dogOutline.heightAnchor.constraint(equalTo: dogOutline.widthAnchor),
                dogOutline.bottomAnchor.constraint(equalTo: datePicker.topAnchor),
                dogOutline.leftAnchor.constraint(equalTo: datePicker.leftAnchor)
            ])
        }
    private func setSaveButtonConstraints() {
        self.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 6),
            saveButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.06),
            saveButton.leftAnchor.constraint(equalTo: datePicker.leftAnchor),
            saveButton.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -3)
        ])
    }
    private func setCancelButtonConstraints() {
        self.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 6),
            cancelButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.06),
            cancelButton.rightAnchor.constraint(equalTo: datePicker.rightAnchor),
            cancelButton.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 3)
        ])
    }
    private func setCornerRadiusForElements() {
        saveButton.layer.cornerRadius = saveButton.bounds.height / 2
        cancelButton.layer.cornerRadius = saveButton.bounds.height / 2
    }
}

// MARK: - Methods

@objc
extension DatePickerView {
    private func saveInformation() {
        delegate?.transferInformation(datePicker.date)
    }
    private func dismissController() {
        delegate?.dismissController()
    }
}
