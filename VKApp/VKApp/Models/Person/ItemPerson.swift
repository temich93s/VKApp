// ItemPerson.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Друг пользователя
final class ItemPerson: Object, Decodable {
    /// id пользователя
    @objc dynamic var id: Int
    /// Имя, Фамилия, ссылка на фото пользователя
    @objc dynamic var firstName, lastName, photo: String

    // MARK: - enum

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_100"
    }
}
