// PhotoService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Протокол, декларирующий метод по перезагрузки ячейки
protocol DataReloadable {
    func reloadRow(at indexPath: IndexPath)
}

/// Cервис для загрузки, кеширования изображений
final class PhotoService {
    // MARK: - Constants

    private enum Constants {
        static let imagesText = "images"
        static let separatorText: Character = "/"
        static let defaultText: Substring = "default"
        static let fileManagerDefault = FileManager.default
    }

    // MARK: - Private Properties

    private let vkNetworkService = VKNetworkService()
    private let cacheLifeTime: TimeInterval = 30 * 24 * 60 * 60
    private let container: DataReloadable

    private static let pathName: String = {
        let pathName = Constants.imagesText
        guard
            let cachesDirectory = Constants.fileManagerDefault.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return pathName }
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        if !Constants.fileManagerDefault.fileExists(atPath: url.path) {
            try? Constants.fileManagerDefault.createDirectory(
                at: url,
                withIntermediateDirectories: true,
                attributes: nil
            )
        }
        return pathName
    }()

    private var imagesMap: [String: UIImage] = [:]

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
        if let photo = imagesMap[url] {
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
            let cachesDirectory = Constants.fileManagerDefault.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return nil }
        let hashName = url.split(separator: Constants.separatorText).last ?? Constants.defaultText
        return cachesDirectory.appendingPathComponent("\(PhotoService.pathName)\(Constants.separatorText)\(hashName)")
            .path
    }

    private func saveImageToCache(url: String, image: UIImage) {
        guard
            let fileName = getFilePath(url: url),
            let data = image.pngData()
        else { return }
        Constants.fileManagerDefault.createFile(atPath: fileName, contents: data, attributes: nil)
    }

    private func getImageFromCache(url: String) -> UIImage? {
        guard
            let fileName = getFilePath(url: url),
            let info = try? Constants.fileManagerDefault.attributesOfItem(atPath: fileName),
            let modificationDate = info[FileAttributeKey.modificationDate] as? Date
        else { return nil }
        let lifeTime = Date().timeIntervalSince(modificationDate)
        guard
            lifeTime <= cacheLifeTime,
            let image = UIImage(contentsOfFile: fileName)
        else { return nil }
        DispatchQueue.main.async {
            self.imagesMap[url] = image
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
                self.imagesMap[url] = image
            }
            self.saveImageToCache(url: url, image: image)
            DispatchQueue.main.async {
                self.container.reloadRow(at: indexPath)
            }
        }
    }
}
