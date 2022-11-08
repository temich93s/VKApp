// NewsImageCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Ячейка с одним из избражений поста
final class NewsImageCollectionViewCell: UICollectionViewCell {
    // MARK: - Private Outlets

    @IBOutlet private var newsImageView: UIImageView!

    // MARK: - Public Methods

    func configureCell(newsImageName: String) {
        newsImageView.image = UIImage(named: newsImageName)
    }
}
