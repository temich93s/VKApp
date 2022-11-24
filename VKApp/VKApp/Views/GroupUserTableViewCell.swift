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

    // MARK: - Public Methods

    func configure(group: Group) {
        selectionStyle = .none
        groupNameLabel.text = group.groupName
        setImage(userPhotoURLText: group.groupPhotoName)
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

    private func setImage(userPhotoURLText: String) {
        let url = URL(string: userPhotoURLText)
        DispatchQueue.global().async {
            guard let url = url else { return }
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                guard let data = data else { return }
                self.groupPhotoImageView.image = UIImage(data: data)
            }
        }
    }
}
