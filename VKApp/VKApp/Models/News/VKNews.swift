// VKNews.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Список новостей текущего пользователя
final class VKNews: Decodable {
    /// ответ с сервера о новостях текущего пользователя
    let response: ResponseVKNews
}
