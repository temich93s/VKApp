// PhotoService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Протокол, декларирующий метод по перезагрузки ячейки
private protocol DataReloadable {
    func reloadRow(atIndexpath indexPath: IndexPath)
}

/// Cервис для загрузки, кеширования изображений
class PhotoService {
    // MARK: - Private Properties

    private let vkNetworkService = VKNetworkService()
    private let cacheLifeTime: TimeInterval = 30 * 24 * 60 * 60
    private let container: DataReloadable

    private static let pathName: String = {
        let pathName = "images"
        guard
            let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return pathName }
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        return pathName
    }()

    private var images = [String: UIImage]()

    // MARK: - Initializers

    init(container: UITableView) {
        self.container = Table(table: container)
    }

    init(container: UICollectionView) {
        self.container = Collection(collection: container)
    }

    init(container: UICollectionViewController) {
        self.container = CollectionViewController(collection: container)
    }

    init(container: UITableViewController) {
        self.container = TableViewController(table: container)
    }

    // MARK: - Public Methods

    func photo(atIndexpath indexPath: IndexPath, byUrl url: String) -> UIImage? {
        var image: UIImage?
        if let photo = images[url] {
            image = photo
        } else if let photo = getImageFromCache(url: url) {
            image = photo
        } else {
            loadPhoto(atIndexpath: indexPath, byUrl: url)
        }
        return image
    }

    // MARK: - Private Methods

    private func getFilePath(url: String) -> String? {
        guard
            let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return nil }
        let hashName = url.split(separator: "/").last ?? "default"
        return cachesDirectory.appendingPathComponent(PhotoService.pathName + "/" + hashName).path
    }

    private func saveImageToCache(url: String, image: UIImage) {
        guard
            let fileName = getFilePath(url: url),
            let data = image.pngData()
        else { return }
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }

    private func getImageFromCache(url: String) -> UIImage? {
        guard
            let fileName = getFilePath(url: url),
            let info = try? FileManager.default.attributesOfItem(atPath: fileName),
            let modificationDate = info[FileAttributeKey.modificationDate] as? Date
        else { return nil }
        let lifeTime = Date().timeIntervalSince(modificationDate)
        guard
            lifeTime <= cacheLifeTime,
            let image = UIImage(contentsOfFile: fileName)
        else { return nil }
        DispatchQueue.main.async {
            self.images[url] = image
        }
        return image
    }

    private func loadPhoto(atIndexpath indexPath: IndexPath, byUrl url: String) {
        vkNetworkService.loadData(urlPath: url) { [weak self] data in
            guard
                let self = self,
                let data = data,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async {
                self.images[url] = image
            }
            self.saveImageToCache(url: url, image: image)
            DispatchQueue.main.async {
                self.container.reloadRow(atIndexpath: indexPath)
            }
        }
    }
}

/// Расширение добавляющее возможность хранить в контейнере DataReloadable классы UITableView, UICollectionView,
/// UICollectionViewController
extension PhotoService {
    private class Table: DataReloadable {
        let table: UITableView

        init(table: UITableView) {
            self.table = table
        }

        func reloadRow(atIndexpath indexPath: IndexPath) {
            table.reloadRows(at: [indexPath], with: .none)
        }
    }

    private class TableViewController: DataReloadable {
        let table: UITableViewController

        init(table: UITableViewController) {
            self.table = table
        }

        func reloadRow(atIndexpath indexPath: IndexPath) {
            table.tableView.reloadRows(at: [indexPath], with: .none)
        }
    }

    private class Collection: DataReloadable {
        let collection: UICollectionView

        init(collection: UICollectionView) {
            self.collection = collection
        }

        func reloadRow(atIndexpath indexPath: IndexPath) {
            collection.reloadItems(at: [indexPath])
        }
    }

    private class CollectionViewController: DataReloadable {
        let collection: UICollectionViewController

        init(collection: UICollectionViewController) {
            self.collection = collection
        }

        func reloadRow(atIndexpath indexPath: IndexPath) {
            collection.collectionView.reloadItems(at: [indexPath])
        }
    }
}
