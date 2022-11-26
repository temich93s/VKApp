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
        userPhotoURLText: Constants.emptyText,
        userPhotoNames: [Constants.friendPhotoOneText],
        id: 0
    )

    // MARK: - Public Methods

    func configure(user: User) {
        friendNameLabel.text = user.userName
        setImage(userPhotoURLText: user.userPhotoURLText)
        self.user = user
    }

    // MARK: - Private Methods

    private func setupFriendPhoto() {
        selectionStyle = .none
        friendPhotoImageView.layer.cornerRadius = friendPhotoImageView.frame.width / 2
        shadowView.shadowColor = .blue
    }

    private func setImage(userPhotoURLText: String) {
        let url = URL(string: userPhotoURLText)
        DispatchQueue.global().async {
            guard let url = url else { return }
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                guard let data = data else { return }
                self.friendPhotoImageView.image = UIImage(data: data)
            }
        }
    }
}
