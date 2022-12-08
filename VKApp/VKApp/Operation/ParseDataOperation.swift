// ParseDataOperation.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class ParseDataOperation: Operation {
    var outputData: [ItemPerson] = []

    override func main() {
        guard
            let getDataOperation = dependencies.first as? GetDataOperation,
            let data = getDataOperation.data,
            let itemsPerson = try? JSONDecoder().decode(Person.self, from: data).response.items
        else { return }
        outputData = itemsPerson
        print("3332222")
    }
}
