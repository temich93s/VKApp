// ResponseVKNews.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Ответ с сервера о новости вконтакте
final class ResponseVKNews: Decodable {
    /// Новости
    let items: [Newsfeed]
    /// Идентификатор получения следующей страницы новостей
    let nextFrom: String?

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case items
        case nextFrom = "next_from"
    }
}
