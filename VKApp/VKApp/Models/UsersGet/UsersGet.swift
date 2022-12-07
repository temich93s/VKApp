// UsersGet.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// ИНформация о пользователях
final class UsersGet: Decodable {
    /// Ответ с сервера о пользователях
    let response: [ResponseUsersGet]
}
