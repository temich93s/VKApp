// PhotosItem.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Фотография
final class PhotosItem: Decodable {
    /// Размеры фотографии
    let sizes: [Size]

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case sizes
    }
}
