// LoginVKViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
import WebKit

/// Окно авторизации VK
final class LoginVKViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let httpsText = "https"
        static let oauthVkComText = "oauth.vk.com"
        static let authorizeText = "/authorize"
        static let clientIdText = "client_id"
        static let clientIdNumberText = "51482678"
        static let displayText = "display"
        static let mobileText = "mobile"
        static let redirectUriText = "redirect_uri"
        static let redirectUriValueText = "https://oauth.vk.com/blank.html"
        static let scopeText = "scope"
        static let scopeNumberText = "262150"
        static let responseTypeText = "response_type"
        static let tokenText = "token"
        static let vText = "v"
        static let vValueText = "5.68"
        static let blankHtmlText = "/blank.html"
        static let ampersandText = "&"
        static let equalText = "="
        static let accessTokenText = "access_token"
        static let userIdText = "user_id"
        static let friendsGetText = "friends.get"
    }

    // MARK: - Private Outlets

    @IBOutlet var webview: WKWebView! {
        didSet {
            webview.navigationDelegate = self
        }
    }

    // MARK: - Private properties

    private let vkService = VKService()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupURLComponents()
    }

    // MARK: - Private Methods

    private func setupURLComponents() {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.httpsText
        urlComponents.host = Constants.oauthVkComText
        urlComponents.path = Constants.authorizeText
        urlComponents.queryItems = [
            URLQueryItem(name: Constants.clientIdText, value: Constants.clientIdNumberText),
            URLQueryItem(name: Constants.displayText, value: Constants.mobileText),
            URLQueryItem(name: Constants.redirectUriText, value: Constants.redirectUriValueText),
            URLQueryItem(name: Constants.scopeText, value: Constants.scopeNumberText),
            URLQueryItem(name: Constants.responseTypeText, value: Constants.tokenText),
            URLQueryItem(name: Constants.vText, value: Constants.vValueText)
        ]
        guard let safeURL = urlComponents.url else { return }
        let request = URLRequest(url: safeURL)
        webview.load(request)
    }

    private func getFriends() {
        vkService.loadVKData(
            method: Constants.friendsGetText,
            parameterMap: [Constants.userIdText: String(Session.instance.userId)]
        )
    }

    private func getPhotoPerson() {}

    private func getGroupCurrentUser() {}

    private func getGroup(name: String) {}
}

// MARK: - WKNavigationDelegate

extension LoginVKViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationResponse:
        WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
    ) {
        guard let url = navigationResponse.response.url, url.path == Constants.blankHtmlText,
              let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }
        let params = fragment
            .components(separatedBy: Constants.ampersandText)
            .map { $0.components(separatedBy: Constants.equalText) }.reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        let token = params[Constants.accessTokenText]
        let userId = params[Constants.userIdText]
        guard let safeToken = token, let userIdString = userId, let safeUserId = Int(userIdString) else { return }
        Session.instance.token = safeToken
        Session.instance.userId = safeUserId
        decisionHandler(.cancel)

        getFriends()
        getPhotoPerson()
        getGroupCurrentUser()
        getGroup(name: "Retrowave")
    }
}
