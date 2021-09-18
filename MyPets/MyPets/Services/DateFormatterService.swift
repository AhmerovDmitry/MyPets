//
//  DateFormatterService.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 17.09.2021.
//

import UIKit

protocol FormatterDate {
    func dateToString(_ date: Date) -> String
    func stringToDate(_ string: String) -> Date
}

final class DateFormatterService: FormatterDate {
    let formatter = DateFormatter()

    func dateToString(_ date: Date) -> String {
        formatter.dateFormat = "dd.MM.yy"
        let date = formatter.string(from: date)
        return date
    }

    func stringToDate(_ string: String) -> Date {
        formatter.dateFormat = "dd.MM.yy"
        guard let date = formatter.date(from: string) else { return Date() }
        return date
    }
}
