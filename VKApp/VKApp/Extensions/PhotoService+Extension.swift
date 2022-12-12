// PhotoService+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Хранение в контейнере DataReloadable классы таблиц и коллекций
extension PhotoService {
    class Table: DataReloadable {
        let table: UITableView

        init(table: UITableView) {
            self.table = table
        }

        func reloadRow(at indexPath: IndexPath) {
            table.reloadRows(at: [indexPath], with: .none)
        }
    }

    class TableViewController: DataReloadable {
        let table: UITableViewController

        init(table: UITableViewController) {
            self.table = table
        }

        func reloadRow(at indexPath: IndexPath) {
            table.tableView.reloadRows(at: [indexPath], with: .none)
        }
    }

    class Collection: DataReloadable {
        let collection: UICollectionView

        init(collection: UICollectionView) {
            self.collection = collection
        }

        func reloadRow(at indexPath: IndexPath) {
            collection.reloadItems(at: [indexPath])
        }
    }

    class CollectionViewController: DataReloadable {
        let collection: UICollectionViewController

        init(collection: UICollectionViewController) {
            self.collection = collection
        }

        func reloadRow(at indexPath: IndexPath) {
            collection.collectionView.reloadItems(at: [indexPath])
        }
    }
}
