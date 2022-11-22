// VKService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Менеджер сетевых запросов по API VK
class VKService {
    // MARK: - Constants

    private enum Constants {
        static let methodText = "/method/"
        static let userIdText = "user_id"
        static let fieldsText = "fields"
        static let accessTokenText = "access_token"
        static let vText = "v"
        static let bdateText = "bdate"
        static let bdateNumberText = "5.131"
        static let baseUrl = "https://api.vk.com"
    }

    // MARK: - Public Methods

    func loadVKData(method: String) {
        let path = "/method/" + method
        let parameters: Parameters = [
            Constants.userIdText: String(Session.instance.userId),
            Constants.fieldsText: Constants.bdateText,
            Constants.accessTokenText: Session.instance.token,
            Constants.vText: Constants.bdateNumberText
        ]
        let url = Constants.baseUrl + path
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { repsonse in
            print(repsonse.value)
        }
    }

    /*
     // MARK: - Public Methods

     func loadVKData(method: String) {
         let session = URLSession(configuration: configuration)
         var urlConstructor = URLComponents()
         urlConstructor.scheme = "https"
         urlConstructor.host = "api.vk.com"
         urlConstructor.path = "/method/" + method
         urlConstructor.queryItems = [
             URLQueryItem(name: "user_id", value: String(Session.instance.userId)),
             URLQueryItem(name: "fields", value: "bdate"),
             URLQueryItem(name: "access_token", value: Session.instance.token),
             URLQueryItem(name: "v", value: "5.131"),
         ]
         guard let safeURL = urlConstructor.url else { return }
         let task = session.dataTask(with: safeURL) { data, _, _ in
             guard let safeData = data else { return }
             let json = try? JSONSerialization.jsonObject(
                 with: safeData,
                 options: JSONSerialization.ReadingOptions.allowFragments
             )
             print(json)
         }
         task.resume()
     }
     */
}
