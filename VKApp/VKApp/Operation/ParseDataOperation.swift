// ParseDataOperation.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Асинхронный парсинг данных
final class ParseDataOperation: Operation {
    // MARK: - Public Properties

    var itemPersons: [ItemPerson] = []

    // MARK: - Public Methods

    override func main() {
        guard
            let getDataOperation = dependencies.first as? GetDataOperation,
            let data = getDataOperation.data,
            let itemsPerson = try? JSONDecoder().decode(Person.self, from: data).response.items
        else { return }
        itemPersons = itemsPerson
    }
}
