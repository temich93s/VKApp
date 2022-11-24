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

    func configure(userPhoto: String) {
        setImage(userPhotoURLText: userPhoto)
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
