// ResponsePhoto.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Ответ с сервера о фотографии
final class ResponsePhoto: Decodable {
    /// Количество фотографий
    let count: Int
    /// Фотографии
    let items: [ItemPhoto]
}
