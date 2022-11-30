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

    func loadFromRealmVKGroups() -> [VKGroups]? {
        do {
            let realm = try Realm()
            let groupsResults = realm.objects(VKGroups.self)
            let vkGroups = Array(groupsResults)
            return vkGroups
        } catch {}
        return nil
    }

    func loadFromRealmItemPerson() -> [ItemPerson]? {
        do {
            let realm = try Realm()
            let persons = realm.objects(ItemPerson.self)
            let itemPerson = Array(persons)
            //            let realm = try Realm()
            //            let persons = Array(realm.objects(ItemPerson.self))
            //            setupUI(persons: persons)

            return itemPerson
        } catch {}
        return nil
    }
}
