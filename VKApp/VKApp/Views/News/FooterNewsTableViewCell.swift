// FooterNewsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка - нижний колонтитул новости
final class FooterNewsTableViewCell: UITableViewCell {
    // MARK: - Private Outlets

    @IBOutlet private var likeLabel: UILabel!
    @IBOutlet private var viewsLabel: UILabel!

    // MARK: - Public Methods

    func configure(news: Newsfeed) {
        likeLabel.text = "\(news.likes?.count ?? 0)"
        viewsLabel.text = "\(news.views?.count ?? 0)"
    }
}
