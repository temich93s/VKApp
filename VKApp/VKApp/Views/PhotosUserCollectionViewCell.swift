// PhotosUserCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с фотографией пользователя
final class PhotosUserCollectionViewCell: UICollectionViewCell {
    // MARK: - Private Outlets

    @IBOutlet private var friendPhotoImageView: UIImageView!

    // MARK: - Public Methods

    func configureCell(userPhoto: String) {
        friendPhotoImageView.image = UIImage(named: userPhoto)
    }

    func animateShowFriendPhotoImageView() {
        let animationScaleX = CABasicAnimation(keyPath: "transform.scale.x")
        animationScaleX.fromValue = 0
        animationScaleX.toValue = 1
        animationScaleX.duration = 1
        friendPhotoImageView.layer.add(animationScaleX, forKey: nil)
        let animationScaleY = CABasicAnimation(keyPath: "transform.scale.y")
        animationScaleY.fromValue = 0
        animationScaleY.toValue = 1
        animationScaleY.duration = 1
        friendPhotoImageView.layer.add(animationScaleY, forKey: nil)
        let animationOpacity = CABasicAnimation(keyPath: "opacity")
        animationOpacity.fromValue = 0
        animationOpacity.toValue = 1
        animationOpacity.duration = 1
        friendPhotoImageView.layer.add(animationOpacity, forKey: nil)
    }

    func animateHideFriendPhotoImageView() {
        let animationScaleX = CABasicAnimation(keyPath: "transform.scale.x")
        animationScaleX.fromValue = 1
        animationScaleX.toValue = 0
        animationScaleX.duration = 1
        friendPhotoImageView.layer.add(animationScaleX, forKey: nil)
        let animationScaleY = CABasicAnimation(keyPath: "transform.scale.y")
        animationScaleY.fromValue = 1
        animationScaleY.toValue = 0
        animationScaleY.duration = 1
        friendPhotoImageView.layer.add(animationScaleY, forKey: nil)
        let animationOpacity = CABasicAnimation(keyPath: "opacity")
        animationOpacity.fromValue = 1
        animationOpacity.toValue = 0
        animationOpacity.duration = 1
        friendPhotoImageView.layer.add(animationOpacity, forKey: nil)
    }
}
