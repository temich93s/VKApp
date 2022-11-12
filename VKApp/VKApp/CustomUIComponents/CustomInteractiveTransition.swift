// CustomInteractiveTransition.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Управление интерактивным переходом между экранами
final class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    // MARK: - Visual Properties

    var viewController: UIViewController? {
        didSet {
            let recognizer = UIScreenEdgePanGestureRecognizer(
                target: self,
                action: #selector(handleScreenEdgeGestureAction(_:))
            )
            recognizer.edges = [.left]
            viewController?.view.addGestureRecognizer(recognizer)
        }
    }

    // MARK: - Public Properties

    var hasStarted = false

    // MARK: - Private Properties

    private var shouldFinished = false

    // MARK: - Private methods

    @objc private func handleScreenEdgeGestureAction(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            hasStarted = true
            viewController?.navigationController?.popViewController(animated: true)
        case .changed:
            let translation = recognizer.translation(in: recognizer.view)
            let relativeTranslation = translation.y / (recognizer.view?.bounds.width ?? 1)
            let progress = max(0, min(1, relativeTranslation))
            shouldFinished = progress > 0.33
            update(progress)
        case .ended:
            hasStarted = false
            if shouldFinished {
                finish()
            } else {
                cancel()
            }
        case .cancelled:
            hasStarted = false
            cancel()
        default: return
        }
    }
}
