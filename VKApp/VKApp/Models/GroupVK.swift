// GroupVK.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// GroupVK
struct GroupVK: Codable {
    let response: ResponseGroupVK
}

/// ResponseGroupVK
struct ResponseGroupVK: Codable {
    let count: Int
    let items: [ItemGroupVK]
}

/// ItemGroupVK
struct ItemGroupVK: Codable {
    let id: Int
    let name: String
    let photo200: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case photo200 = "photo_200"
    }
}
