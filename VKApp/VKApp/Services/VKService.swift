// VKService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Менеджер сетевых запросов по API VK
struct VKService {
    // MARK: - Publick Properties

    static let configuration = URLSessionConfiguration.default

    // MARK: - Public Methods

    static func loadVKData(method: String) {
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
}
