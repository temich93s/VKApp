// PostNewsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Изменение высоты ячейки
protocol PostNewsTableCellDelegate: AnyObject {
    func didTappedShowTextButton(cell: PostNewsTableViewCell)
}

/// Новость типа пост
final class PostNewsTableViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let zeroNumber = 0
        static let threeNumber = 3
    }

    // MARK: - Private Outlets

    @IBOutlet private var postLabel: UILabel!
    @IBOutlet private var showTextButton: UIButton!

    // MARK: - Public Properties

    weak var delegate: PostNewsTableCellDelegate?

    var isExpanded = false {
        didSet {
            updateCell()
        }
    }

    // MARK: - Public Methods

    func configure(news: Newsfeed) {
        postLabel.text = news.text
        updateCell()
    }

    // MARK: - Private Action

    @IBAction private func showTextAction(_ sender: UIButton) {
        delegate?.didTappedShowTextButton(cell: self)
    }

    // MARK: - Private Methods

    private func updateCell() {
        postLabel.numberOfLines = isExpanded ? Constants.zeroNumber : Constants.threeNumber
        let title = isExpanded ? "Show less..." : "Show more..."
        showTextButton.setTitle(title, for: .normal)
    }
}
