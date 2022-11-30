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
            print(realm.configuration.fileURL)
            try realm.write {
                realm.add(groupVK, update: .modified)
            }
        } catch {}
    }

    func deleteGroupVKData(_ groupVK: VKGroups) {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
            try realm.write {
                realm.delete(groupVK)
            }
        } catch {}
    }

    func saveFriendsData(_ friends: [ItemPerson]) {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
            try realm.write {
                realm.add(friends, update: .modified)
            }
        } catch {}
    }

    func savePhotosData(_ photos: ItemPerson) {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
            try realm.write {
                realm.add(photos, update: .modified)
            }
        } catch {}
    }

    func loadData<T: Object>(objectType: T.Type) -> Results<T>? {
        do {
            let realm = try Realm()
            let results = realm.objects(objectType)
            return results
        } catch {}
        return nil
    }
}
