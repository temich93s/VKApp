// ResponseVKNews.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Ответ с сервера о новости вконтакте
final class ResponseVKNews: Decodable {
    /// Новости
    let items: [Newsfeed]

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case items
    }
}
