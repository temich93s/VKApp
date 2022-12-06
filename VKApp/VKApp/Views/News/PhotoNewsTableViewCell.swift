// PhotoNewsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Новость типа фото
final class PhotoNewsTableViewCell: UITableViewCell {
    // MARK: - Private Outlets

    @IBOutlet private var photoImageView: UIImageView!

    // MARK: - Public Methods

    override func prepareForReuse() {
        photoImageView.image = nil
    }

    func configure(news: Newsfeed, networkService: VKNetworkService) {
        photoImageView.setupImage(urlPath: news.photos?.items.first?.sizes.last?.url, networkService: networkService)
    }
}
