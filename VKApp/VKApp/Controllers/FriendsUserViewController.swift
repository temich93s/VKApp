// FriendsUserViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с друзьями пользователя
class FriendsUserViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let friendsUserCellID = "FriendsUserCell"
        static let segueID = "GoToPhotosUserCollectionVC"
        static let friendPhotoOneName = "FriendPhotoOne"
        static let friendPhotoSecondName = "FriendPhotoSecond"
        static let friendPhotoThirdName = "FriendPhotoThird"
        static let friendNameOneName = "Андрей"
        static let friendNameSecondName = "Егор"
        static let friendNameThirdName = "Никита"
    }

    @IBOutlet var friendsTableView: UITableView!

    // MARK: - Private Properties

    private var friends = [
        User(userName: Constants.friendPhotoOneName, userPhotoName: Constants.friendPhotoOneName),
        User(userName: Constants.friendPhotoSecondName, userPhotoName: Constants.friendPhotoSecondName),
        User(userName: Constants.friendPhotoThirdName, userPhotoName: Constants.friendPhotoThirdName),
        User(userName: Constants.friendPhotoOneName, userPhotoName: Constants.friendPhotoOneName),
        User(userName: Constants.friendPhotoSecondName, userPhotoName: Constants.friendPhotoSecondName),
        User(userName: Constants.friendPhotoThirdName, userPhotoName: Constants.friendPhotoThirdName),
        User(userName: Constants.friendPhotoOneName, userPhotoName: Constants.friendPhotoOneName),
        User(userName: Constants.friendPhotoSecondName, userPhotoName: Constants.friendPhotoSecondName),
        User(userName: Constants.friendPhotoThirdName, userPhotoName: Constants.friendPhotoThirdName),
        User(userName: Constants.friendPhotoOneName, userPhotoName: Constants.friendPhotoOneName),
        User(userName: Constants.friendPhotoSecondName, userPhotoName: Constants.friendPhotoSecondName),
        User(userName: Constants.friendPhotoThirdName, userPhotoName: Constants.friendPhotoThirdName),
        User(userName: Constants.friendPhotoOneName, userPhotoName: Constants.friendPhotoOneName),
        User(userName: Constants.friendPhotoSecondName, userPhotoName: Constants.friendPhotoSecondName),
        User(userName: Constants.friendPhotoThirdName, userPhotoName: Constants.friendPhotoThirdName),
        User(userName: Constants.friendPhotoOneName, userPhotoName: Constants.friendPhotoOneName),
        User(userName: Constants.friendPhotoSecondName, userPhotoName: Constants.friendPhotoSecondName),
        User(userName: Constants.friendPhotoThirdName, userPhotoName: Constants.friendPhotoThirdName)
    ]

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Public Methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == Constants.segueID,
            let destination = segue.destination as? PhotosUserCollectionViewController,
            let cell = sender as? FriendsUserTableViewCell
        else { return }
        destination.configurePhotosUserCollectionVC(currentUser: cell.user)
    }

    // MARK: - Private Methods

    private func setupView() {
        friendsTableView.delegate = self
        friendsTableView.dataSource = self
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension FriendsUserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView
            .dequeueReusableCell(
                withIdentifier: Constants.friendsUserCellID,
                for: indexPath
            ) as? FriendsUserTableViewCell,
            indexPath.row < friends.count
        else { return UITableViewCell() }
        cell.configureCell(user: friends[indexPath.row])
        return cell
    }
}
