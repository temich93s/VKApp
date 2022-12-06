// Newsfeed.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Новость пользователя
final class Newsfeed: Decodable {
    /// тип списка новости
    let type: PostTypeEnum
    /// идентификатор источника новости
    let sourceID: Int
    /// время публикации новости
    let date: Int
    /// фотографии
    let photos: Photos?
    /// текст записи
    let text: String?
    /// лайки новости
    let likes: PurpleLikes?
    /// просмотри новости
    let views: Views?

    // MARK: - enum

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
