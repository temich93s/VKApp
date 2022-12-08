// SaveDataOperation.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class SaveDataOperation: Operation {
    // MARK: - Private Properties

    private let realmService = RealmService()

    // MARK: - Public Methods

    override func main() {
        guard let getParseData = dependencies.first as? ParseDataOperation else { return }
        let parseData = getParseData.outputData
        realmService.saveFriendsData(parseData)
    }
}
