// PhotosUserCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с фотографией пользователя
final class PhotosUserCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants

    private enum Constants {
        static let transformScaleXText = "transform.scale.x"
        static let transformScaleYText = "transform.scale.y"
        static let opacityText = "opacity"
        static let friendPhotoOneText = "FriendPhotoOne"
    }

    // MARK: - Private Outlets

    @IBOutlet private var friendPhotoImageView: UIImageView!

    // MARK: - Public Methods

    func configureCell(userPhoto: String) {
        friendPhotoImageView.image = getImage(by: userPhoto)
    }

    func animateShowFriendPhotoImageView() {
        let animationScaleX = CABasicAnimation(keyPath: Constants.transformScaleXText)
        setupAnimation(animation: animationScaleX, fromValue: 0, toValue: 1, duration: 1)
        friendPhotoImageView.layer.add(animationScaleX, forKey: nil)
        let animationScaleY = CABasicAnimation(keyPath: Constants.transformScaleYText)
        setupAnimation(animation: animationScaleY, fromValue: 0, toValue: 1, duration: 1)
        friendPhotoImageView.layer.add(animationScaleY, forKey: nil)
        let animationOpacity = CABasicAnimation(keyPath: Constants.opacityText)
        setupAnimation(animation: animationOpacity, fromValue: 0, toValue: 1, duration: 1)
        friendPhotoImageView.layer.add(animationOpacity, forKey: nil)
    }

    func animateHideFriendPhotoImageView() {
        let animationScaleX = CABasicAnimation(keyPath: Constants.transformScaleXText)
        setupAnimation(animation: animationScaleX, fromValue: 1, toValue: 0, duration: 1)
        friendPhotoImageView.layer.add(animationScaleX, forKey: nil)
        let animationScaleY = CABasicAnimation(keyPath: Constants.transformScaleYText)
        setupAnimation(animation: animationScaleY, fromValue: 1, toValue: 0, duration: 1)
        friendPhotoImageView.layer.add(animationScaleY, forKey: nil)
        let animationOpacity = CABasicAnimation(keyPath: Constants.opacityText)
        setupAnimation(animation: animationOpacity, fromValue: 1, toValue: 0, duration: 1)
        friendPhotoImageView.layer.add(animationOpacity, forKey: nil)
    }

    // MARK: - Private Methods

    private func setupAnimation(animation: CABasicAnimation, fromValue: Double, toValue: Double, duration: Double) {
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = duration
    }

    // MARK: - Private Methods

    private func getImage(by name: String) -> UIImage? {
        UIImage(named: name)
    }
}
