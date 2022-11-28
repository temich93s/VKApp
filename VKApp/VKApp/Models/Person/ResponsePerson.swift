// ResponsePerson.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Ответ с сервера о пользователе
final class ResponsePerson: Decodable {
    /// Кол-во друзей
    let count: Int
    /// Друзья пользователя
    let items: [ItemPerson]
}
