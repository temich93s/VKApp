// PurpleLikes.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Лайки
final class PurpleLikes: Decodable {
    /// Количество лайков
    let count: Int

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case count
    }
}
