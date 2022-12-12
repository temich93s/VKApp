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

    func configure(url: String, photoService: PhotoService?, indexPath: IndexPath) {
        photoImageView.image = photoService?.photo(atIndexpath: indexPath, byUrl: url)
    }
}
