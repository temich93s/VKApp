// AnimationService.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Cервис анимирования UI элементов
final class AnimationService {
    // MARK: - Constants

    private enum Constants {
        static let transformScaleXText = "transform.scale.x"
        static let transformScaleYText = "transform.scale.y"
        static let opacityText = "opacity"
        static let friendPhotoOneText = "FriendPhotoOne"
        static let transformScaleText = "transform.scale"
    }

    // MARK: - Public Methods

    func animateJumpImageView(imageView: UIImageView) {
        let animation = CASpringAnimation(keyPath: Constants.transformScaleText)
        animation.fromValue = 0.5
        animation.toValue = 1
        animation.stiffness = 100
        animation.mass = 2
        animation.duration = 1
        animation.beginTime = CACurrentMediaTime()
        animation.fillMode = CAMediaTimingFillMode.forwards
        imageView.layer.add(animation, forKey: nil)
    }

    func animateShowImageView(imageView: UIImageView) {
        let animationScaleX = CABasicAnimation(keyPath: Constants.transformScaleXText)
        setupAnimation(animation: animationScaleX, fromValue: 0, toValue: 1, duration: 1)
        imageView.layer.add(animationScaleX, forKey: nil)
        let animationScaleY = CABasicAnimation(keyPath: Constants.transformScaleYText)
        setupAnimation(animation: animationScaleY, fromValue: 0, toValue: 1, duration: 1)
        imageView.layer.add(animationScaleY, forKey: nil)
        let animationOpacity = CABasicAnimation(keyPath: Constants.opacityText)
        setupAnimation(animation: animationOpacity, fromValue: 0, toValue: 1, duration: 1)
        imageView.layer.add(animationOpacity, forKey: nil)
    }

    func animateHideImageView(imageView: UIImageView) {
        let animationScaleX = CABasicAnimation(keyPath: Constants.transformScaleXText)
        setupAnimation(animation: animationScaleX, fromValue: 1, toValue: 0, duration: 1)
        imageView.layer.add(animationScaleX, forKey: nil)
        let animationScaleY = CABasicAnimation(keyPath: Constants.transformScaleYText)
        setupAnimation(animation: animationScaleY, fromValue: 1, toValue: 0, duration: 1)
        imageView.layer.add(animationScaleY, forKey: nil)
        let animationOpacity = CABasicAnimation(keyPath: Constants.opacityText)
        setupAnimation(animation: animationOpacity, fromValue: 1, toValue: 0, duration: 1)
        imageView.layer.add(animationOpacity, forKey: nil)
    }

    // MARK: - Private Methods

    private func setupAnimation(animation: CABasicAnimation, fromValue: Double, toValue: Double, duration: Double) {
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = duration
    }
}
