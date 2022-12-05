// NewsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с новостной лентой
final class NewsViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let newsTableViewCellID = "NewsTableViewCell"
        static let firstUserName = "Никита"
        static let firstUserPhotoName = "FriendPhotoOne"
        static let firstUserNewsDateText = "11.12.2016"
        static let firstUserNewsText = "Всем самого счастливого дня!"
        static let firstUserNewsImagesName = ["FriendPhotoSecond", "FriendPhotoThird"]
        static let firstUserNewsLikeCount = 12
        static let secondUserName = "Виталя"
        static let secondUserPhotoName = "FriendPhotoSecond"
        static let secondUserNewsDateText = "14.12.2016"
        static let secondUserNewsText = "Всем хороших выходных!"
        static let secondUserNewsImagesName = [
            "FriendPhotoOne",
            "FriendPhotoSecond",
            "FriendPhotoThird",
            "FriendPhotoSecond"
        ]
        static let secondUserNewsLikeCount = 19
        static let thirdUserName = "Иван"
        static let thirdUserPhotoName = "FriendPhotoThird"
        static let thirdUserNewsDateText = "18.12.2016"
        static let thirdUserNewsText = "Всем хороших праздников!"
        static let thirdUserNewsImagesName = ["FriendPhotoSecond"]
        static let thirdUserNewsLikeCount = 26
    }

    // MARK: - Private Outlets

    @IBOutlet private var newsTableView: UITableView!

    // MARK: - Private Properties

    private let vkNetworkService = VKNetworkService()
    private var userNews: [Newsfeed] = []
    private var allNews = [
        News(
            userName: Constants.firstUserName,
            userPhotoName: Constants.firstUserPhotoName,
            userNewsDateText: Constants.firstUserNewsDateText,
            newsText: Constants.firstUserNewsText,
            newsImagesName: Constants.firstUserNewsImagesName,
            newsLikeCount: Constants.firstUserNewsLikeCount
        ),
        News(
            userName: Constants.secondUserName,
            userPhotoName: Constants.secondUserPhotoName,
            userNewsDateText: Constants.secondUserNewsDateText,
            newsText: Constants.secondUserNewsText,
            newsImagesName: Constants.secondUserNewsImagesName,
            newsLikeCount: Constants.secondUserNewsLikeCount
        ),
        News(
            userName: Constants.thirdUserName,
            userPhotoName: Constants.thirdUserPhotoName,
            userNewsDateText: Constants.thirdUserNewsDateText,
            newsText: Constants.thirdUserNewsText,
            newsImagesName: Constants.thirdUserNewsImagesName,
            newsLikeCount: Constants.thirdUserNewsLikeCount
        )
    ]

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
    }

    private func hightCellForImageCollection(numberRow: Int) -> CGFloat {
        guard numberRow < allNews.count else { return 0 }
        switch allNews[numberRow].newsImagesName.count {
        case 1:
            return view.bounds.width
        case let count where count > 1:
            return (view.bounds.width / 2) * CGFloat(lroundf(Float(allNews[numberRow].newsImagesName.count) / 2))
        default:
            return 0
        }
    }

    private func fetchUserNewsVK() {
        vkNetworkService.fetchUserNewsVK { items in
            // print(items)
            for item in items {
                // print(item.photos?.items.last?.sizes.last?.url)
                print(item.views?.count)
                // print(item.type)
            }
            print("111111")
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allNews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.newsTableViewCellID,
                for: indexPath
            ) as? NewsTableViewCell,
            indexPath.row < allNews.count
        else { return UITableViewCell() }

        cell.configure(
            news: allNews[indexPath.row],
            viewHight: hightCellForImageCollection(numberRow: indexPath.row)
        )
        return cell
    }
}
