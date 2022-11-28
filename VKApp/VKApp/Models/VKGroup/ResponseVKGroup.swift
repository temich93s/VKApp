// ResponseVKGroup.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Ответ с сервера о группе вконтакте
final class ResponseVKGroup: Decodable {
    /// Количество групп вконтакте
    let count: Int
    /// Группы вконтакте
    let items: [VKGroups]
}
