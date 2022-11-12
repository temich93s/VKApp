// MainNavigationController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Навигейшн контроллер с анимациями вперед и назад, где VС поворачивается относительно верхнего правого угла
final class MainNavigationController: UINavigationController {
    // MARK: - Private Properties

    private let interactiveTransition = CustomInteractiveTransition()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
    }

    // MARK: - Private Methods

    private func setupNavigationController() {
        delegate = self
    }
}

// MARK: - UINavigationControllerDelegate

extension MainNavigationController: UINavigationControllerDelegate {
    // MARK: - Public Methods

    func navigationController(
        _ navigationController: UINavigationController,
        interactionControllerFor animationController:
        UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        interactiveTransition.hasStarted ? interactiveTransition : nil
    }

    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            interactiveTransition.viewController = toVC
            return CustomPushAnimator()
        case .pop:
            if navigationController.viewControllers.first != toVC {
                interactiveTransition.viewController = toVC
            }
            return CustomPopAnimator()
        default:
            return nil
        }
    }
}
