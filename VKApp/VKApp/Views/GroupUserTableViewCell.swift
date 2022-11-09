// GroupUserTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с группой и фотографией группы в которых пользователь не состоит
final class GroupUserTableViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let emptyText = ""
        static let transformScaleText = "transform.scale"
    }

    // MARK: - Private Outlets

    @IBOutlet private var groupNameLabel: UILabel!
    @IBOutlet private var groupPhotoImageView: UIImageView!

    // MARK: - Public Properties

    var group = Group(groupName: Constants.emptyText, groupPhotoName: Constants.emptyText)

    // MARK: - Public Methods

    func configureCell(group: Group) {
        selectionStyle = .none
        groupNameLabel.text = group.groupName
        groupPhotoImageView.image = getImage(by: group.groupPhotoName)
        self.group = group
    }

    func animateGroupPhotoImageView() {
        let animation = CASpringAnimation(keyPath: Constants.transformScaleText)
        animation.fromValue = 0.5
        animation.toValue = 1
        animation.stiffness = 100
        animation.mass = 2
        animation.duration = 1
        animation.beginTime = CACurrentMediaTime()
        animation.fillMode = CAMediaTimingFillMode.forwards
        groupPhotoImageView.layer.add(animation, forKey: nil)
    }

    // MARK: - Private Methods

    private func getImage(by name: String) -> UIImage? {
        UIImage(named: name)
    }
}
