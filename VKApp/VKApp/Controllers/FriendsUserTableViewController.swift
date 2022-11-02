// FriendsUserTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с друзьями пользователя
final class FriendsUserTableViewController: UITableViewController {
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
