// User.swift
// Copyright © RoadMap. All rights reserved.

/// Пользователь
struct User {
    /// Имя пользователя
    let userName: String
    /// Имя фото самого пользователя
    let userPhotoURLText: String
    /// Имена фотографий пользователя
    var userPhotoNames: [String]
    /// Идентификатор пользователя на портале VK
    let id: Int
}
