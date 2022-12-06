// Size.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Размер фотографии
final class Size: Decodable {
    /// ссылка по которой хранится фотография
    let url: String

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case url
    }
}
