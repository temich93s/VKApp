// ItemPerson.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Друг пользователя
@objcMembers
final class ItemPerson: Object, Decodable {
    /// id пользователя
    dynamic var id = 0
    /// Имя пользователя
    dynamic var firstName: String = ""
    /// Фамилия пользователя
    dynamic var lastName: String = ""
    /// Ссылка на фото пользователя
    dynamic var photo: String = ""
    /// Фотографии пользователя
    var photos = List<ItemPhoto>()
    /// Полное имя пользователя
    var fullName: String {
        "\(firstName) \(lastName)"
    }

    // MARK: - enum

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_100"
    }

    // MARK: - Public Methods

    override class func primaryKey() -> String? {
        "id"
    }
}
