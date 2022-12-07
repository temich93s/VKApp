// UIViewController+Alert.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Добавление Alert для UIViewController
extension UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let okText = "OK"
    }

    // MARK: - Public Methods

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: Constants.okText, style: .cancel, handler: nil))
        present(alertController, animated: true)
    }

    func showErrorAlert(alertTitle: String?, message: String?, actionTitle: String?) {
        let errorAlertController = UIAlertController(
            title: alertTitle,
            message: message,
            preferredStyle: .alert
        )
        let okErrorAlertControllerAction = UIAlertAction(
            title: actionTitle,
            style: .cancel
        )
        errorAlertController.addAction(okErrorAlertControllerAction)
        present(errorAlertController, animated: true)
    }
}
