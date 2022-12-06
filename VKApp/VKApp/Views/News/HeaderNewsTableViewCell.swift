// HeaderNewsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка - верний колонтитул новости
final class HeaderNewsTableViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let dateFormatText = "HH:mm   dd MMMM"
    }

    // MARK: - Private Outlets

    @IBOutlet private var imageAuthorImageView: UIImageView!
    @IBOutlet private var nameAuthorLabel: UILabel!
    @IBOutlet private var dateNewsAuthorLabel: UILabel!

    // MARK: - Public Methods

    override func prepareForReuse() {
        imageAuthorImageView.image = nil
    }

    func configure(news: Newsfeed, vkNetworkService: VKNetworkService) {
        nameAuthorLabel.text = "\(news.sourceID)"
        let date = Date(timeIntervalSinceReferenceDate: Double(news.date))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormatText
        dateNewsAuthorLabel.text = dateFormatter.string(from: date)
        vkNetworkService.fetchAuthorVK(authorID: "\(news.sourceID)") { [weak self] person in
            guard let self = self else { return }
            self.imageAuthorImageView.setupImage(urlPath: person.photo100, networkService: vkNetworkService)
            self.nameAuthorLabel.text = person.fullName
        }
    }
}
