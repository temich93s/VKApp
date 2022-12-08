// ParseDataOperation.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Операция по парсингу данных
final class ParseDataOperation: Operation {
    // MARK: - Public Properties

    var outputData: [ItemPerson] = []

    // MARK: - Public Methods

    override func main() {
        guard
            let getDataOperation = dependencies.first as? GetDataOperation,
            let data = getDataOperation.data,
            let itemsPerson = try? JSONDecoder().decode(Person.self, from: data).response.items
        else { return }
        outputData = itemsPerson
    }
}
