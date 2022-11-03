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
        static let friendNameFourName = "Артем"
        static let friendNameFiveName = "Иван"
        static let friendNameSixName = "Андрей"
        static let friendNameSevenName = "Антон"
        static let friendNameEightName = "Олег"
        static let friendNameNineName = "Виталя"
        static let friendNameTenName = "Максим"
    }

    // MARK: - IBOutlet

    @IBOutlet private var characterSetControl: CharacterSetControl!
    @IBOutlet private var friendsTableView: UITableView!

    // MARK: - Private Properties

    private var friends = [
        User(userName: Constants.friendNameOneName, userPhotoName: Constants.friendPhotoOneName),
        User(userName: Constants.friendNameSecondName, userPhotoName: Constants.friendPhotoSecondName),
        User(userName: Constants.friendNameThirdName, userPhotoName: Constants.friendPhotoThirdName),
        User(userName: Constants.friendNameFourName, userPhotoName: Constants.friendPhotoOneName),
        User(userName: Constants.friendNameFiveName, userPhotoName: Constants.friendPhotoSecondName),
        User(userName: Constants.friendNameSixName, userPhotoName: Constants.friendPhotoThirdName),
        User(userName: Constants.friendNameEightName, userPhotoName: Constants.friendPhotoOneName),
        User(userName: Constants.friendNameSevenName, userPhotoName: Constants.friendPhotoSecondName),
        User(userName: Constants.friendNameNineName, userPhotoName: Constants.friendPhotoThirdName),
        User(userName: Constants.friendNameTenName, userPhotoName: Constants.friendPhotoOneName),
        User(userName: Constants.friendNameOneName, userPhotoName: Constants.friendPhotoOneName),
        User(userName: Constants.friendNameSecondName, userPhotoName: Constants.friendPhotoSecondName),
        User(userName: Constants.friendNameThirdName, userPhotoName: Constants.friendPhotoThirdName),
        User(userName: Constants.friendNameFourName, userPhotoName: Constants.friendPhotoOneName),
        User(userName: Constants.friendNameFiveName, userPhotoName: Constants.friendPhotoSecondName),
        User(userName: Constants.friendNameSixName, userPhotoName: Constants.friendPhotoThirdName),
        User(userName: Constants.friendNameEightName, userPhotoName: Constants.friendPhotoOneName),
        User(userName: Constants.friendNameSevenName, userPhotoName: Constants.friendPhotoSecondName),
        User(userName: Constants.friendNameNineName, userPhotoName: Constants.friendPhotoThirdName),
        User(userName: Constants.friendNameTenName, userPhotoName: Constants.friendPhotoOneName)
    ]

    private var characters: [Character] = []

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
        setupCharacters()
    }

    private func setupCharacters() {
        characters = []
        for friend in friends {
            guard
                !friend.userName.isEmpty,
                let safeChatacter = friend.userName.first,
                !characters.contains(safeChatacter)
            else { continue }
            characters.append(safeChatacter)
        }
        characters.sort()
        characterSetControl.characterSet = characters
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension FriendsUserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        setupCharacters()
        return friends.count
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
