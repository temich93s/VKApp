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

    override func prepareForReuse() {
        imageAuthorImageView.image = nil
    }

    func configure(news: Newsfeed, vkNetworkService: VKNetworkService) {
        nameAuthorLabel.text = "\(news.sourceID)"
        dateNewsAuthorLabel.text = DateFormatter.getNewsDate(dateInt: news.date)
        fetchAuthorVK(news: news, vkNetworkService: vkNetworkService)
    }

    private func fetchAuthorVK(news: Newsfeed, vkNetworkService: VKNetworkService) {
        vkNetworkService.fetchAuthorVK(authorID: "\(news.sourceID)") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .fulfilled(response):
                self.imageAuthorImageView.setupImage(urlPath: response.photo100, networkService: vkNetworkService)
                self.nameAuthorLabel.text = response.fullName
            case .rejected:
                return
            }
        }
    }
}
