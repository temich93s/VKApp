// Person.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Пользователь
class Person: Decodable {
    let response: ResponsePerson
}

/// Response
class ResponsePerson: Decodable {
    let count: Int
    let items: [ItemPerson]
}

/// Item
class ItemPerson: Object, Decodable {
    @objc dynamic var id: Int
    @objc dynamic var firstName, lastName, photo: String

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_100"
    }
}
