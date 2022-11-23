// VKService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Менеджер сетевых запросов по API VK
final class VKService {
    // MARK: - Constants

    private enum Constants {
        static let methodText = "/method/"
        static let fieldsText = "fields"
        static let accessTokenText = "access_token"
        static let vText = "v"
        static let bdateText = "bdate"
        static let bdateNumberText = "5.131"
        static let baseUrl = "https://api.vk.com"
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
        static let vValueText = "5.68"
    }

    // MARK: - Public Methods

    func sendRequest(method: String, parameterMap: [String: String]) {
        let path = Constants.methodText + method
        var parameters: Parameters = [
            Constants.fieldsText: Constants.bdateText,
            Constants.accessTokenText: Session.shared.token,
            Constants.vText: Constants.bdateNumberText
        ]
        for parameter in parameterMap {
            parameters[parameter.key] = parameter.value
        }
        let url = "\(Constants.baseUrl)\(path)"
        print(url)
        print(parameters)
        Alamofire.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            let weather = try? JSONDecoder().decode(Person.self, from: data).response.items
            print(weather ?? "")
        }
    }

    func createUrlComponents() -> URLComponents {
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
        return urlComponents
    }
}
