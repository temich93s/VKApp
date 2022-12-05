// PurpleLikes.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Количество лайков
final class PurpleLikes: Decodable {
    let count: Int

    enum CodingKeys: String, CodingKey {
        case count
    }
}
