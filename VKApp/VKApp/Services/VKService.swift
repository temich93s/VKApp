// VKService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation
import RealmSwift

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

    // MARK: - Public Methods

    func sendRequestFriend(
        method: String,
        parameterMap: [String: String],
        completion: @escaping ([ItemPerson]) -> Void
    ) {
        let path = Constants.methodText + method
        for parameter in parameterMap {
            parameters[parameter.key] = parameter.value
        }
        let url = "\(Constants.baseUrl)\(path)"
        Alamofire.request(url, method: .get, parameters: parameters).responseData { response in
            guard
                let data = response.value,
                let items = try? JSONDecoder().decode(Person.self, from: data).response.items
            else { return }
            self.saveFriendsData(items)
            completion(items)
        }
    }

    func sendRequestPhotos(
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
        Alamofire.request(url, method: .get, parameters: parameters).responseData { response in
            print("2222")
            guard
                let data = response.value,
                let items = try? JSONDecoder().decode(Photo.self, from: data).response.items
            else { return }
            print("2233")
            var photosURLText: [String] = []
//            for item in items {
//                for itemSize in item.sizes where itemSize.type == "z" {
//                    photosURLText.append(itemSize.url)
//                }
//            }
            for item in items {
                photosURLText.append(item.url)
            }
            print(items)
            completion(photosURLText)
        }
    }

    func sendRequestGroupVK(
        method: String,
        parameterMap: [String: String],
        completion: @escaping ([ItemGroupVK]) ->
            Void
    ) {
        let path = Constants.methodText + method
        for parameter in parameterMap {
            parameters[parameter.key] = parameter.value
        }
        let url = "\(Constants.baseUrl)\(path)"
        Alamofire.request(url, method: .get, parameters: parameters).responseData { response in
            guard
                let data = response.value,
                let items = try? JSONDecoder().decode(GroupVK.self, from: data).response.items
            else { return }
            self.saveGroupVKData(items)
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

    func saveGroupVKData(_ groupVK: [ItemGroupVK]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(groupVK)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }

    func saveFriendsData(_ friends: [ItemPerson]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(friends)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }

//    func savePhotosData(_ photos: [ItemPhoto]) {
//        do {
//            let realm = try Realm()
//            realm.beginWrite()
//            realm.add(photos)
//            try realm.commitWrite()
//        } catch {
//            print(error)
//        }
//    }
}
