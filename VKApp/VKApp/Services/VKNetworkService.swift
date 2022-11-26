// VKNetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation
import RealmSwift

/// Менеджер сетевых запросов по API VK
final class VKNetworkService {
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
        static let clientIdNumberText = "51485381"
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

    // MARK: - Private Properties

    private var parameters: Parameters = [
        Constants.fieldsText: Constants.bdateText,
        Constants.accessTokenText: Session.shared.token,
        Constants.vText: Constants.bdateNumberText
    ]

    private var realmService = RealmService()

    // MARK: - Public Methods

    func fetchFriend(
        method: String,
        parameterMap: [String: String],
        completion: @escaping ([ItemPerson]) -> Void
    ) {
        let path = Constants.methodText + method
        for parameter in parameterMap {
            parameters[parameter.key] = parameter.value
        }
        let url = "\(Constants.baseUrl)\(path)"
        Alamofire.request(url, method: .get, parameters: parameters).responseData { [weak self] response in
            guard
                let self = self,
                let data = response.value,
                let items = try? JSONDecoder().decode(Person.self, from: data).response.items
            else { return }
            self.realmService.saveFriendsData(items)
            completion(items)
        }
    }

    func fetchPhotos(
        method: String,
        parameterMap: [String: String],
        completion: @escaping ([String]) ->
            Void
    ) {
        let path = Constants.methodText + method
        for parameter in parameterMap {
            parameters[parameter.key] = parameter.value
        }
        let url = "\(Constants.baseUrl)\(path)"
        Alamofire.request(url, method: .get, parameters: parameters).responseData { [weak self] response in
            guard
                let self = self,
                let data = response.value,
                let items = try? JSONDecoder().decode(Photo.self, from: data).response.items
            else { return }
            var photosURLText: [String] = []
            for item in items {
                photosURLText.append(item.url)
            }
            self.realmService.savePhotosData(items)
            completion(photosURLText)
        }
    }

    func fetchGroupVK(
        method: String,
        parameterMap: [String: String],
        completion: @escaping ([VKGroups]) ->
            Void
    ) {
        let path = Constants.methodText + method
        for parameter in parameterMap {
            parameters[parameter.key] = parameter.value
        }
        let url = "\(Constants.baseUrl)\(path)"
        Alamofire.request(url, method: .get, parameters: parameters).responseData { [weak self] response in
            guard
                let self = self,
                let data = response.value,
                let items = try? JSONDecoder().decode(VKGroup.self, from: data).response.items
            else { return }
            self.realmService.saveGroupVKData(items)
            completion(items)
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

    func setupImage(urlPath: String?, imageView: UIImageView) {
        guard
            let urlPath = urlPath,
            let url = URL(string: urlPath)
        else { return }
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                guard let data = data else { return }
                imageView.image = UIImage(data: data)
            }
        }
    }
}
