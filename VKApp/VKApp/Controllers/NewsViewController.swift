// NewsViewController.swift
// Copyright © RoadMap. All rights reserved.

import PromiseKit
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
        static let refreshText = "Обновление новостей..."
        static let lightBlueColorText = "LightBlueColor"
        static let okText = "OK"
        static let countCellNumber = 3
        static let oneNumber = 1
    }

    // MARK: - Private Outlets

    @IBOutlet private var newsTableView: UITableView!

    // MARK: - Private Properties

    private let vkNetworkService = VKNetworkService()

    private var userNews: [Newsfeed] = []
    private var photoService: PhotoService?
    private var nextFrom = String()
    private var isLoading = false

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchUserNewsVK()
    }

    // MARK: - Private Methods

    private func setupView() {
        setupRefreshControl()
        photoService = PhotoService(container: newsTableView)
        newsTableView.rowHeight = UITableView.automaticDimension
        newsTableView.dataSource = self
        newsTableView.delegate = self
        newsTableView.prefetchDataSource = self
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
        vkNetworkService.fetchNewsVK(nextFrom: nextFrom) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .fulfilled((news, nextFrom)):
                self.userNews = self.filterNews(news: news)
                self.nextFrom = nextFrom
                self.newsTableView.reloadData()
            case let .rejected(error):
                self.showErrorAlert(alertTitle: nil, message: error.localizedDescription, actionTitle: nil)
            }
        }
    }

    private func setupRefreshControl() {
        newsTableView.refreshControl = UIRefreshControl()
        newsTableView.refreshControl?.attributedTitle = NSAttributedString(string: Constants.refreshText)
        newsTableView.refreshControl?.tintColor = UIColor(named: Constants.lightBlueColorText)
        newsTableView.refreshControl?.addTarget(self, action: #selector(refreshNewsAction), for: .valueChanged)
    }

    private func filterNews(news: [Newsfeed]) -> [Newsfeed] {
        var filteredNews: [Newsfeed] = []
        for oneNews in news where (oneNews.type == .post) || (oneNews.type == .photo) {
            filteredNews.append(oneNews)
        }
        return filteredNews
    }

    @objc private func refreshNewsAction() {
        newsTableView.refreshControl?.beginRefreshing()
        guard let dateInt = userNews.first?.date else { return }
        let mostFreshNewsDate = Double(dateInt)
        vkNetworkService
            .fetchNewNewsVK(startTime: mostFreshNewsDate + Double(Constants.oneNumber)) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .fulfilled(news):
                    self.newsTableView.refreshControl?.endRefreshing()
                    guard news.count > 0 else { return }
                    self.userNews = self.filterNews(news: news) + self.userNews
                    let indexSet = IndexSet(integersIn: 0 ..< news.count)
                    self.newsTableView.insertSections(indexSet, with: .automatic)
                case .rejected:
                    self.newsTableView.refreshControl?.endRefreshing()
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
        cell.delegate = self
        cell.configure(news: userNews[indexPath.section])
        return cell
    }

    private func photoNewsTableViewCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.photoNewsTableViewCellID,
                for: indexPath
            ) as? PhotoNewsTableViewCell,
            let url = userNews[indexPath.section].photos?.items.first?.sizes.last?.url,
            indexPath.section < userNews.count
        else { return UITableViewCell() }
        cell.configure(url: url, photoService: photoService, section: indexPath.section)
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

// MARK: - UITableViewDataSourcePrefetching

extension NewsViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard
            let maxSection = indexPaths.map(\.section).max(),
            maxSection > userNews.count - Constants.countCellNumber,
            !isLoading
        else { return }
        isLoading = true
        vkNetworkService.fetchNewsVK(nextFrom: nextFrom) { [weak self] results in
            guard let self = self else { return }
            switch results {
            case let .fulfilled((news, nextFrom)):
                let indexSet = IndexSet(integersIn: self.userNews.count ..< self.userNews.count + news.count)
                self.userNews.append(contentsOf: news)
                self.newsTableView.insertSections(indexSet, with: .automatic)
                self.nextFrom = nextFrom
                self.isLoading = false
            case .rejected:
                self.isLoading = false
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 1 where userNews[indexPath.section].type == .photo:
            let tableWidth = newsTableView.bounds.width
            let aspectRatio = CGFloat(
                userNews[indexPath.section].photos?.items.first?.sizes.first?
                    .aspectRatio ?? Float(Constants.oneNumber)
            )
            let cellHeight = tableWidth * aspectRatio
            return cellHeight
        default:
            return UITableView.automaticDimension
        }
    }
}

// MARK: - NewsPostCellDelegate

extension NewsViewController: PostNewsTableCellDelegate {
    func didTappedShowTextButton(cell: PostNewsTableViewCell) {
        newsTableView.beginUpdates()
        cell.isExpanded.toggle()
        newsTableView.endUpdates()
    }
}
