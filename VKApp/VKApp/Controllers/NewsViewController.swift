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
        newsTableView.register(
            UINib(nibName: "FooterNewsTableViewCell", bundle: nil),
            forCellReuseIdentifier: "FooterNewsTableViewCell"
        )
        newsTableView.register(
            UINib(nibName: "HeaderNewsTableViewCell", bundle: nil),
            forCellReuseIdentifier: "HeaderNewsTableViewCell"
        )
        newsTableView.register(
            UINib(nibName: "PostNewsTableViewCell", bundle: nil),
            forCellReuseIdentifier: "PostNewsTableViewCell"
        )
    }

//    private func hightCellForImageCollection(numberRow: Int) -> CGFloat {
//        guard numberRow < allNews.count else { return 0 }
//        switch allNews[numberRow].newsImagesName.count {
//        case 1:
//            return view.bounds.width
//        case let count where count > 1:
//            return (view.bounds.width / 2) * CGFloat(lroundf(Float(allNews[numberRow].newsImagesName.count) / 2))
//        default:
//            return 0
//        }
//    }

    private func hightCellForImageCollection(numberRow: Int) -> CGFloat {
        100
    }

    private func fetchUserNewsVK() {
        vkNetworkService.fetchUserNewsVK { items in
            for item in items {
                // print(item.photos?.items.last?.sizes.last?.url)
                print(item.likes?.count)
            }
            print("111111")
            self.userNews = items
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
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "PostNewsTableViewCell",
                    for: indexPath
                ) as? PostNewsTableViewCell,
                indexPath.section < userNews.count
            else { return UITableViewCell() }
            cell.configure(news: userNews[indexPath.section])
            return cell
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
