// News.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Новости
struct News {
    /// Имя пользователя
    let userName: String
    /// Имя фотографии пользователя
    let userPhotoName: String
    /// Дата публикации новости пользователя
    let userNewsDateText: String
    /// Текст новости
    let newsText: String
    /// Изображения новости
    let newsImagesName: [String]
    /// Количество лайков
    let newsLikeCount: Int
}
