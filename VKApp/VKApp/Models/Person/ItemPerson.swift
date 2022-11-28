// ItemPerson.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Друг пользователя
final class ItemPerson: Object, Decodable {
    /// id пользователя
    @objc dynamic var id = 0
    /// Имя пользователя
    @objc dynamic var firstName: String = ""
    /// Фамилия пользователя
    @objc dynamic var lastName: String = ""
    /// Ссылка на фото пользователя
    @objc dynamic var photo: String = ""
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
