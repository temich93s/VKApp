// Photo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// RequestPhoto
struct Photo: Codable {
    let response: ResponsePhoto
}

/// Response
struct ResponsePhoto: Codable {
    let count: Int
    let items: [ItemPhoto]
}

/// Item
struct ItemPhoto: Codable {
    let sizes: [Size]
}

/// Size
struct Size: Codable {
    let type: String
    let url: String
}
