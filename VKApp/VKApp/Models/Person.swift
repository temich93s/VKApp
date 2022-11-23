// Person.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Пользователь
struct Person: Codable {
    let response: Response
}

/// Response
struct Response: Codable {
    let count: Int
    let items: [Item]
}

/// Item
struct Item: Codable {
    let id: Int
    let firstName, lastName, photo: String

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_100"
    }
}
