// LoginVKViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
import WebKit

/// Окно авторизации VK
final class LoginVKViewController: UIViewController {
    // MARK: - Private Outlets

    @IBOutlet var webview: WKWebView! {
        didSet {
            webview.navigationDelegate = self
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupURLComponents()
    }

    // MARK: - Private Methods

    private func setupURLComponents() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "51482678"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        guard let safeURL = urlComponents.url else { return }
        let request = URLRequest(url: safeURL)
        webview.load(request)
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
        guard let url = navigationResponse.response.url, url.path == "/blank.html",
              let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }.reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        let token = params["access_token"]
        let userId = params["user_id"]
        guard let safeToken = token, let userIdString = userId, let safeUserId = Int(userIdString) else { return }
        Session.instance.token = safeToken
        Session.instance.userId = safeUserId
        decisionHandler(.cancel)

        let vkService = VKService()
        vkService.loadVKData(method: "friends.get")
    }
}
