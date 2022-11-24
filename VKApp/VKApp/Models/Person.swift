// Person.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Пользователь ВК
final class Person: Decodable {
    let response: ResponsePerson
}

/// Ответ с сервера о пользователе
final class ResponsePerson: Decodable {
    /// Кол-во друзей
    let count: Int
    /// Друзья пользователя
    let items: [ItemPerson]
}

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
