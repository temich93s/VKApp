// SaveDataOperation.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class SaveDataOperation: Operation {
    private let realmService = RealmService()

    override func main() {
        guard let getParseData = dependencies.first as? ParseDataOperation else { return }
        let parseData = getParseData.outputData
        realmService.saveFriendsData(parseData)
        print("3333333")
    }
}
