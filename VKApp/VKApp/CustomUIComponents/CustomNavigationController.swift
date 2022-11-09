// CustomNavigationController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Наш кастомный UINavigationController который наполнен анимациями
final class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    // MARK: - Public Methods

    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            // return CustomPushAnimator()
        } else if operation == .pop {
            // return CustomPopAnimator()
            // test
        }
        return nil
    }
}
