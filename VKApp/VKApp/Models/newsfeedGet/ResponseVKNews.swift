// ResponseVKNews.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Ответ с сервера о новости вконтакте
final class ResponseVKNews: Decodable {
    /// Новости
    let items: [Newsfeed]

    // MARK: - enum

    enum CodingKeys: String, CodingKey {
        case items
    }
}
