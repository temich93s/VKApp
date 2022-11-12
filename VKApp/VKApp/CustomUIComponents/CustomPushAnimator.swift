// CustomPushAnimator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Анимация перехода вперед
final class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: - Constants

    private enum Constants {
        static let animationDurationNumber = 0.6
        static let coefficientTranslationXNumber: CGFloat = 1.5
        static let coefficientTranslationYNumber: CGFloat = 4
        static let coefficientRotationNumber: CGFloat = 2
    }

    // MARK: - Public Methods

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        Constants.animationDurationNumber
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else { return }

        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = source.view.frame
        let rotation = CGAffineTransform(rotationAngle: -.pi / Constants.coefficientRotationNumber)
        let translation = CGAffineTransform(
            translationX: destination.view.frame.width * Constants.coefficientTranslationXNumber,
            y: -destination.view.frame.width / Constants.coefficientTranslationYNumber
        )
        destination.view.transform = rotation.concatenating(translation)

        UIView.animateKeyframes(
            withDuration: transitionDuration(using: transitionContext),
            delay: 0,
            options: .calculationModePaced,
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0,
                    relativeDuration: 1,
                    animations: {
                        source.view.transform = CGAffineTransform(translationX: source.view.frame.width, y: 0)
                    }
                )
                UIView.addKeyframe(
                    withRelativeStartTime: 0,
                    relativeDuration: 1,
                    animations: {
                        destination.view.transform = .identity
                    }
                )
            }, completion: { finished in
                if finished, !transitionContext.transitionWasCancelled {
                    source.view.transform = .identity
                }
                transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
            }
        )
    }
}
