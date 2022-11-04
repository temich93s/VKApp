// Group.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Group: данные о группе
/// - groupName: имя группы
/// - groupPhotoName: имя фото группы
struct Group {
    let groupName: String
    let groupPhotoName: String
}

// MARK: - Equatable

extension Group: Equatable {}
