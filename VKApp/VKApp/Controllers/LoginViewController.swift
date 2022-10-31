// LoginViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// MARK: - LoginViewController

/// Окно авторизации пользователя
final class LoginViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let lightBlueColorName = "LightBlueColor"
        static let darkBlueColorName = "DarkBlueColor"
        static let whiteColorName = "WhiteColor"
        static let loginPlaceholderText = "Email или телефон"
        static let passwordPlaceholderText = "Пароль"
        static let enterButtonText = "Войти"
        static let forgotPasswordButtonText = "Забыли пароль?"
        static let loginSegueIdentifier = "LoginSegue"
        static let titleAlertText = "Ошибка"
        static let messageAlertText = "Логин или пароль неверные"
        static let correctLoginText = "admin"
        static let correctPasswordText = "12345"
    }

    // MARK: - Private Outlets

    @IBOutlet private var loginTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var enterButton: UIButton!
    @IBOutlet private var forgotPasswordButton: UIButton!
    @IBOutlet private var mainScrollView: UIScrollView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShown(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        mainScrollView.addGestureRecognizer(tapGesture)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    @IBAction func loginButtonAction(_ sender: UIButton) {
        if checkLoginInfo() {
            performSegue(withIdentifier: Constants.loginSegueIdentifier, sender: self)
        } else {
            showAlert(title: Constants.titleAlertText, message: Constants.messageAlertText)
        }
    }

    // MARK: - Private Methods

    private func setupUI() {
        setupMainView()
        setupLoginTextField()
        setupPasswordTextField()
        setupEnterButton()
        setupForgotPasswordButton()
    }

    private func setupMainView() {
        view.backgroundColor = UIColor(named: Constants.lightBlueColorName)
    }

    private func setupLoginTextField() {
        loginTextField.delegate = self
        loginTextField.placeholder = Constants.loginPlaceholderText
        loginTextField.font = UIFont.systemFont(ofSize: 18)
    }

    private func setupPasswordTextField() {
        passwordTextField.delegate = self
        passwordTextField.placeholder = Constants.passwordPlaceholderText
        passwordTextField.font = UIFont.systemFont(ofSize: 18)
        passwordTextField.isSecureTextEntry = true
    }

    private func setupEnterButton() {
        enterButton.setTitle(Constants.enterButtonText, for: .normal)
        enterButton.setTitleColor(UIColor(named: Constants.whiteColorName), for: .normal)
        enterButton.backgroundColor = UIColor(named: Constants.darkBlueColorName)
        enterButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        enterButton.layer.cornerRadius = 10
    }

    private func setupForgotPasswordButton() {
        forgotPasswordButton.setTitle(Constants.forgotPasswordButtonText, for: .normal)
        forgotPasswordButton.setTitleColor(UIColor(named: Constants.whiteColorName), for: .normal)
        forgotPasswordButton.backgroundColor = UIColor(named: Constants.darkBlueColorName)
        forgotPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        forgotPasswordButton.layer.cornerRadius = 10
    }

    @objc private func keyboardWillShown(notification: Notification) {
        guard let info = notification.userInfo as? NSDictionary,
              let keyboard = info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue
        else { return }
        let contectInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboard.cgRectValue.size.height, right: 0)
        mainScrollView.contentInset = contectInsets
        mainScrollView.scrollIndicatorInsets = contectInsets
    }

    @objc private func keyboardWillHide(notification: Notification) {
        mainScrollView.contentInset = UIEdgeInsets.zero
        mainScrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }

    @objc private func hideKeyboard() {
        mainScrollView.endEditing(true)
    }

    private func checkLoginInfo() -> Bool {
        guard let loginText = loginTextField.text, let passwordText = passwordTextField.text else { return false }
        if loginText == Constants.correctLoginText, passwordText == Constants.correctPasswordText {
            return true
        } else {
            return false
        }
    }
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Alert

extension LoginViewController {
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
}
