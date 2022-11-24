// GroupVK.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// GroupVK
class GroupVK: Decodable {
    let response: ResponseGroupVK
}

/// ResponseGroupVK
class ResponseGroupVK: Decodable {
    let count: Int
    let items: [ItemGroupVK]
}

/// ItemGroupVK
class ItemGroupVK: Object, Decodable {
    @objc dynamic var id: Int
    @objc dynamic var name: String
    @objc dynamic var photo200: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case photo200 = "photo_200"
    }
}
