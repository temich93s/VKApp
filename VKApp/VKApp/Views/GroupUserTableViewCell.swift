// GroupUserTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с группой и фотографией группы в которых пользователь не состоит
final class GroupUserTableViewCell: UITableViewCell {
    // MARK: - Private Outlets

    @IBOutlet private var groupNameLabel: UILabel!
    @IBOutlet private var groupPhotoImageView: UIImageView!

    // MARK: - Public Methods

    func configure(group: VKGroups, photoService: PhotoService?, row: Int) {
        selectionStyle = .none
        groupNameLabel.text = group.name
        let indexPath = IndexPath(row: row, section: Int.zero)
        groupPhotoImageView.image = photoService?.photo(atIndexpath: indexPath, byUrl: group.photo200)
    }

    func animateGroupPhotoImageView(animationService: AnimationService) {
        animationService.animateJumpImageView(imageView: groupPhotoImageView)
    }
}
