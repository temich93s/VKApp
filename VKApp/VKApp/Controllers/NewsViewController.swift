// NewsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с новостной лентой
final class NewsViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let newsTableViewCellID = "NewsTableViewCell"
        static let footerNewsTableViewCellID = "FooterNewsTableViewCell"
        static let headerNewsTableViewCellID = "HeaderNewsTableViewCell"
        static let postNewsTableViewCellID = "PostNewsTableViewCell"
        static let photoNewsTableViewCellID = "PhotoNewsTableViewCell"
        static let countCellNumber = 3
    }

    // MARK: - Private Outlets

    @IBOutlet private var newsTableView: UITableView!

    // MARK: - Private Properties

    private let vkNetworkService = VKNetworkService()
    private var userNews: [Newsfeed] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchUserNewsVK()
    }

    // MARK: - Private Methods

    private func setupView() {
        newsTableView.dataSource = self
        newsTableView.rowHeight = UITableView.automaticDimension
        newsTableView.register(
            UINib(nibName: Constants.newsTableViewCellID, bundle: nil),
            forCellReuseIdentifier: Constants.newsTableViewCellID
        )
        newsTableView.register(
            UINib(nibName: Constants.footerNewsTableViewCellID, bundle: nil),
            forCellReuseIdentifier: Constants.footerNewsTableViewCellID
        )
        newsTableView.register(
            UINib(nibName: Constants.headerNewsTableViewCellID, bundle: nil),
            forCellReuseIdentifier: Constants.headerNewsTableViewCellID
        )
        newsTableView.register(
            UINib(nibName: Constants.postNewsTableViewCellID, bundle: nil),
            forCellReuseIdentifier: Constants.postNewsTableViewCellID
        )
        newsTableView.register(
            UINib(nibName: Constants.photoNewsTableViewCellID, bundle: nil),
            forCellReuseIdentifier: Constants.photoNewsTableViewCellID
        )
    }

    private func fetchUserNewsVK() {
        vkNetworkService.fetchUserNewsVK { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .fulfilled(response):
                self.userNews = []
                for item in response where (item.type == .post) || (item.type == .photo) {
                    self.userNews.append(item)
                }
                self.newsTableView.reloadData()
            case let .rejected(error):
                self.showErrorAlert(alertTitle: nil, message: error.localizedDescription, actionTitle: nil)
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension NewsViewController: UITableViewDataSource {
    // MARK: - Public Methods

    func numberOfSections(in tableView: UITableView) -> Int {
        userNews.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Constants.countCellNumber
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return headerNewsTableViewCell(tableView: tableView, indexPath: indexPath)
        case 1:
            switch userNews[indexPath.section].type {
            case .photo:
                return photoNewsTableViewCell(tableView: tableView, indexPath: indexPath)
            case .post:
                return postNewsTableViewCell(tableView: tableView, indexPath: indexPath)
            default:
                return UITableViewCell()
            }
        case 2:
            return footerNewsTableViewCell(tableView: tableView, indexPath: indexPath)
        default:
            return UITableViewCell()
        }
    }

    // MARK: - Private Methods

    private func footerNewsTableViewCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.footerNewsTableViewCellID,
                for: indexPath
            ) as? FooterNewsTableViewCell,
            indexPath.section < userNews.count
        else { return UITableViewCell() }
        cell.configure(news: userNews[indexPath.section])
        return cell
    }

    private func postNewsTableViewCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.postNewsTableViewCellID,
                for: indexPath
            ) as? PostNewsTableViewCell,
            indexPath.section < userNews.count
        else { return UITableViewCell() }
        cell.configure(news: userNews[indexPath.section])
        return cell
    }

    private func photoNewsTableViewCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.photoNewsTableViewCellID,
                for: indexPath
            ) as? PhotoNewsTableViewCell,
            indexPath.section < userNews.count
        else { return UITableViewCell() }
        cell.configure(news: userNews[indexPath.section], networkService: vkNetworkService)
        return cell
    }

    private func headerNewsTableViewCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.headerNewsTableViewCellID,
                for: indexPath
            ) as? HeaderNewsTableViewCell,
            indexPath.section < userNews.count
        else { return UITableViewCell() }
        cell.configure(news: userNews[indexPath.section], vkNetworkService: vkNetworkService)
        return cell
    }
}
