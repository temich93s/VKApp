// FriendsUserViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// MARK: - typealias

typealias Closure = (Character) -> ()

/// Экран с друзьями пользователя
final class FriendsUserViewController: UIViewController {
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
        static let friendNameSixName = "Семен"
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

    private lazy var scrollFromCharacterClousure: Closure? = { [weak self] character in
        guard let self = self else { return }
        let index = self.friends.firstIndex { user -> Bool in
            user.userName.first == character
        }
        guard let safeIndex = index else { return }
        let indexPath = IndexPath(row: safeIndex, section: 0)
        self.friendsTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }

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
        friends.sort {
            $0.userName < $1.userName
        }
        characterSetControl.scrollFromCharacterClousure = scrollFromCharacterClousure
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
