// RealmService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Менеджер работы с RealmSwift
struct RealmService {
    // MARK: - Public Methods

    func saveGroupVKData(_ groupVK: [VKGroups]) {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
            try realm.write {
                realm.add(groupVK, update: .modified)
            }
            print(realm.configuration.fileURL)
        } catch {
            print(error)
        }
    }

    func deleteGroupVKData(_ groupVK: VKGroups) {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
            try realm.write {
                realm.delete(groupVK)
            }
            print(realm.configuration.fileURL)
        } catch {
            print(error)
        }
    }

    func saveFriendsData(_ friends: [ItemPerson]) {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
            try realm.write {
                realm.add(friends, update: .modified)
            }
            print(realm.configuration.fileURL)
        } catch {
            print(error)
        }
    }

    func savePhotosData(_ photos: ItemPerson) {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
            try realm.write {
                realm.add(photos, update: .modified)
            }
            print(realm.configuration.fileURL)
        } catch {
            print(error)
        }
    }
}
