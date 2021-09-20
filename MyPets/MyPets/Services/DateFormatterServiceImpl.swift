//
//  DateFormatterService.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 17.09.2021.
//

import UIKit

protocol DateFormatterService {
    func dateToString(_ date: Date) -> String
    func stringToDate(_ string: String) -> Date?
}

final class DateFormatterServiceImpl: DateFormatterService {
    let formatter = DateFormatter()

    func dateToString(_ date: Date) -> String {
        formatter.dateFormat = "dd.MM.yy"
        let date = formatter.string(from: date)
        return date
    }

    func stringToDate(_ string: String) -> Date? {
        formatter.dateFormat = "dd.MM.yy"
        guard let date = formatter.date(from: string) else { return nil }
        return date
    }
}
