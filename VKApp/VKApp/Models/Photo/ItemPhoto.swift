// ItemPhoto.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Фотография пользователя
@objcMembers
final class ItemPhoto: Object, Decodable {
    /// Размер фотографии
    dynamic var type: String = ""
    /// Ссылка на фотографию
    dynamic var url: String = ""
    /// Владелец фотографий
    let parentCategory = LinkingObjects(fromType: ItemPerson.self, property: "photos")

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
