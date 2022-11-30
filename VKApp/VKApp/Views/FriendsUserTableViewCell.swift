// FriendsUserTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с именем и фотографией друга
final class FriendsUserTableViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let emptyText = ""
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

    var user = ItemPerson()

    // MARK: - Private Properties

    private let vkNetworkService = VKNetworkService()

    // MARK: - Public Methods

    func configure(user: ItemPerson) {
        friendNameLabel.text = user.fullName
        vkNetworkService.setupImage(urlPath: user.photo, imageView: friendPhotoImageView)
        self.user = user
    }

    // MARK: - Private Methods

    private func setupFriendPhoto() {
        selectionStyle = .none
        friendPhotoImageView.layer.cornerRadius = friendPhotoImageView.frame.width / 2
        shadowView.shadowColor = .blue
    }
}
