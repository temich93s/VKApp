// Size.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Размер фотографии
final class Size: Decodable {
    let url: String
    enum CodingKeys: String, CodingKey {
        case url
    }
}
