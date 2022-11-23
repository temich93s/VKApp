// LoginVKViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
import WebKit

/// Окно авторизации VK
final class LoginVKViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let loginSegueIdentifier = "LoginSegue"
        static let blankHtmlText = "/blank.html"
        static let ampersandText = "&"
        static let equalText = "="
        static let accessTokenText = "access_token"
        static let userIdText = "user_id"
        static let friendsGetText = "friends.get"
        static let photosGetAllText = "photos.getAll"
        static let ownerIdText = "owner_id"
        static let groupsGetText = "groups.get"
        static let groupsSearchText = "groups.search"
        static let qText = "q"
        static let testUserText = "43832436"
        static let testGroupText = "Retrowave"
    }

    // MARK: - Private Outlets

    @IBOutlet private var webview: WKWebView! {
        didSet {
            webview.navigationDelegate = self
        }
    }

    // MARK: - Private properties

    private let vkService = VKService()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView()
    }

    // MARK: - Private Methods

    private func loadWebView() {
        let urlComponents = vkService.createUrlComponents()
        guard let safeURL = urlComponents.url else { return }
        let request = URLRequest(url: safeURL)
        webview.load(request)
    }

    private func fetchFriends() {
        vkService.sendRequest(
            method: Constants.friendsGetText,
            parameterMap: [Constants.userIdText: String(Session.shared.userId)]
        )
    }

    private func fetchPhotoPerson(ownerId: String) {
        vkService.sendRequest(
            method: Constants.photosGetAllText,
            parameterMap: [Constants.ownerIdText: ownerId]
        )
    }

    private func fetchCurrentUserGroups() {
        vkService.sendRequest(
            method: Constants.groupsGetText,
            parameterMap: [Constants.userIdText: String(Session.shared.userId)]
        )
    }

    private func fetchSearchedGroups(text: String) {
        vkService.sendRequest(
            method: Constants.groupsSearchText,
            parameterMap: [Constants.qText: text]
        )
    }

    private func fetchRequestVK() {
        fetchFriends()
        fetchPhotoPerson(ownerId: Constants.testUserText)
        fetchCurrentUserGroups()
        fetchSearchedGroups(text: Constants.testGroupText)
    }
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
        Session.shared.token = safeToken
        Session.shared.userId = safeUserId
        decisionHandler(.cancel)
        fetchRequestVK()
        performSegue(withIdentifier: Constants.loginSegueIdentifier, sender: self)
    }
}
