// PostNewsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Новость типа пост
final class PostNewsTableViewCell: UITableViewCell {
    // MARK: - Private Outlets

    @IBOutlet private var postTextView: UITextView!

    // MARK: - Public Methods

    func configure(news: Newsfeed) {
        postTextView.text = news.text
    }
}
