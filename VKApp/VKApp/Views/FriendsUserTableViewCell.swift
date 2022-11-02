// FriendsUserTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// ячейка с именем и фотографией друга
final class FriendsUserTableViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let emptyText = ""
    }

    // MARK: - Private Outlets

    @IBOutlet private var friendNameLabel: UILabel!
    @IBOutlet private var friendPhotoImageView: UIImageView!

    // MARK: - Public Properties

    var user = User(userName: Constants.emptyText, userPhotoName: Constants.emptyText)

    // MARK: - Public Methods

    func configureCell(user: User) {
        friendNameLabel.text = user.userName
        friendPhotoImageView.image = UIImage(named: user.userPhotoName)
        self.user = user
    }
}
