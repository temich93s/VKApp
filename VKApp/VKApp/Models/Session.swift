// Session.swift
// Copyright © RoadMap. All rights reserved.

//
//  Session.swift
//  VKApp
//
//  Created by 2lup on 21.11.2022.
//

/// Хранитель данных о текущей сессии
struct Session {
    static let instance = Session()
    /// токен в VK
    var token = ""
    /// идентификатор пользователя ВК.
    var userId = 0
    private init() {}
}
