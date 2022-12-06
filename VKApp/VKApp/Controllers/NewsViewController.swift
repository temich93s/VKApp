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
        newsTableView.delegate = self
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
            UINib(nibName: "HeaderNewsTableViewCell", bundle: nil),
            forCellReuseIdentifier: "HeaderNewsTableViewCell"
        )
        newsTableView.register(
            UINib(nibName: "PostNewsTableViewCell", bundle: nil),
            forCellReuseIdentifier: "PostNewsTableViewCell"
        )
        newsTableView.register(
            UINib(nibName: "PhotoNewsTableViewCell", bundle: nil),
            forCellReuseIdentifier: "PhotoNewsTableViewCell"
        )
    }

    private func fetchUserNewsVK() {
        vkNetworkService.fetchUserNewsVK { items in
            self.userNews = []
            for item in items where (item.type == .post) || (item.type == .photo) {
                self.userNews.append(item)
            }
            self.newsTableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        userNews.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "HeaderNewsTableViewCell",
                    for: indexPath
                ) as? HeaderNewsTableViewCell,
                indexPath.section < userNews.count
            else { return UITableViewCell() }
            cell.configure(news: userNews[indexPath.section])
            return cell
        case 1:
            switch userNews[indexPath.section].type {
            case .photo:
                guard
                    let cell = tableView.dequeueReusableCell(
                        withIdentifier: "PhotoNewsTableViewCell",
                        for: indexPath
                    ) as? PhotoNewsTableViewCell,
                    indexPath.section < userNews.count
                else { return UITableViewCell() }
                cell.configure(news: userNews[indexPath.section], networkService: vkNetworkService)
                return cell
            case .post:
                guard
                    let cell = tableView.dequeueReusableCell(
                        withIdentifier: "PostNewsTableViewCell",
                        for: indexPath
                    ) as? PostNewsTableViewCell,
                    indexPath.section < userNews.count
                else { return UITableViewCell() }
                cell.configure(news: userNews[indexPath.section])
                return cell
            default:
                return UITableViewCell()
            }
        case 2:
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "FooterNewsTableViewCell",
                    for: indexPath
                ) as? FooterNewsTableViewCell,
                indexPath.section < userNews.count
            else { return UITableViewCell() }
            cell.configure(news: userNews[indexPath.section])
            return cell
        default:
            return UITableViewCell()
        }
    }
}
