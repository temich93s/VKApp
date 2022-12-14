// DateFormatter+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// форматирование даты
extension DateFormatter {
    // MARK: - Constants

    private enum Constants {
        static let dateFormatText = "HH:mm   dd MMMM"
    }

    // MARK: - Public Methods

    static func getNewsDate(dateInt: Int) -> String {
        let date = Date(timeIntervalSinceReferenceDate: Double(dateInt))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormatText
        return dateFormatter.string(from: date)
    }
}
