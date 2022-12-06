// PhotosItem.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Фотография
final class PhotosItem: Decodable {
    /// размеры фотографии
    let sizes: [Size]

    // MARK: - enum

    enum CodingKeys: String, CodingKey {
        case sizes
    }
}
