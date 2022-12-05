// Newsfeed.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Новость пользователя
final class Newsfeed: Decodable {
    var type: PostTypeEnum
    var sourceID: Int
    var date: Int
    var photos: Photos?
    var text: String?
    var likes: PurpleLikes?
    var views: Views?

    enum CodingKeys: String, CodingKey {
        case type
        case sourceID = "source_id"
        case date
        case photos
        case text
        case likes
        case views
    }

    enum PostTypeEnum: String, Codable {
        case friend
        case photo
        case post
        case wallPhoto = "wall_photo"
    }
}
