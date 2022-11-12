// FriendsUserTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с именем и фотографией друга
final class FriendsUserTableViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let emptyText = ""
        static let friendPhotoOneText = "FriendPhotoOne"
    }

    // MARK: - Private Outlets

    @IBOutlet private var friendNameLabel: UILabel!
    @IBOutlet private var friendPhotoImageView: UIImageView!
    @IBOutlet private var shadowView: ShadowView!

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupFriendPhoto()
    }

    // MARK: - Public Properties

    var user = User(
        userName: Constants.emptyText,
        userPhotoName: Constants.emptyText,
        userPhotosName: [Constants.friendPhotoOneText]
    )

    // MARK: - Public Methods

    func configure(user: User) {
        friendNameLabel.text = user.userName
        friendPhotoImageView.image = getImage(by: user.userPhotoName)
        self.user = user
    }

    // MARK: - Private Methods

    private func setupFriendPhoto() {
        selectionStyle = .none
        friendPhotoImageView.layer.cornerRadius = friendPhotoImageView.frame.width / 2
        shadowView.shadowColor = .blue
    }

    // MARK: - Private Methods

    private func getImage(by name: String) -> UIImage? {
        UIImage(named: name)
    }
}
