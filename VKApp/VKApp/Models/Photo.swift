// Photo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Фотография
final class Photo: Decodable {
    let response: ResponsePhoto
}

/// Ответ с сервера о фотографии
final class ResponsePhoto: Decodable {
    /// Количество фотографий
    let count: Int
    /// Фотографии
    let items: [ItemPhoto]
}

/// Фотография пользователя
final class ItemPhoto: Object, Decodable {
    /// Размер фотографии
    @objc dynamic var type: String = ""
    /// Ссылка на фотографию
    @objc dynamic var url: String = ""

    // MARK: - enum

    enum CodingKeys: String, CodingKey {
        case sizes
    }

    enum SizeKeys: String, CodingKey {
        case type
        case url
    }

    // MARK: - Initializers

    convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        var sizeValues = try values.nestedUnkeyedContainer(forKey: .sizes)
        while !sizeValues.isAtEnd {
            let reviewCountContainer = try sizeValues.nestedContainer(keyedBy: SizeKeys.self)
            type = try reviewCountContainer.decode(String.self, forKey: .type)
            url = try reviewCountContainer.decode(String.self, forKey: .url)
        }
    }
}
