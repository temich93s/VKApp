// ResponseVKNews.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Ответ с сервера о новости вконтакте
final class ResponseVKNews: Decodable {
    let items: [Newsfeed]

    enum CodingKeys: String, CodingKey {
        case items
    }
}
