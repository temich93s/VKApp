// PhotosItem.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Размеры фотографии
final class PhotosItem: Decodable {
    let sizes: [Size]

    enum CodingKeys: String, CodingKey {
        case sizes
    }
}
