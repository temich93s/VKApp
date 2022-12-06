// ResponseUsersGet.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Ответ с сервера о пользователе
final class ResponseUsersGet: Decodable {
    /// Идентификатор пользователя.
    let id: Int?
    let photo100: String?
    /// Имя
    let firstName: String?
    /// Фамилия
    let lastName: String?

    /// Полное имя пользователя
    var fullName: String {
        guard
            let firstName = firstName,
            let lastName = lastName
        else { return "" }
        return "\(firstName) \(lastName)"
    }

    // MARK: - enum

    enum CodingKeys: String, CodingKey {
        case id
        case photo100 = "photo_100"
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
