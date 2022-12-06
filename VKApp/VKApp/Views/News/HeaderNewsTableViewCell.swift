// HeaderNewsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка - верний колонтитул новости
final class HeaderNewsTableViewCell: UITableViewCell {
    // MARK: - Private Outlets

    @IBOutlet private var imageAuthorImageView: UIImageView!
    @IBOutlet private var nameAuthorLabel: UILabel!
    @IBOutlet private var dateNewsAuthorLabel: UILabel!

    // MARK: - Public Methods

    func configure(news: Newsfeed) {
        nameAuthorLabel.text = "\(news.sourceID)"
        let date = Date(timeIntervalSinceReferenceDate: Double(news.date))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm   dd MMMM"
        dateNewsAuthorLabel.text = dateFormatter.string(from: date)
    }
}
