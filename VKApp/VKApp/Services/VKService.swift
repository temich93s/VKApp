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
    }

    // MARK: - Public Methods

    func loadVKData(method: String, parameterMap: [String: String]) {
        let path = Constants.methodText + method
        var parameters: Parameters = [
            Constants.fieldsText: Constants.bdateText,
            Constants.accessTokenText: Session.instance.token,
            Constants.vText: Constants.bdateNumberText
        ]
        for parameter in parameterMap {
            parameters[parameter.key] = parameter.value
        }
        let url = Constants.baseUrl + path
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { repsonse in
            print(repsonse.value ?? "")
        }
    }
}
