// SearchGroupTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с поиска групп
final class SearchGroupTableViewController: UITableViewController {
    // MARK: - Constants

    private enum Constants {
        static let groupUserCellID = "SearchGroupCell"
        static let groupUserPhotoOneName = "FriendPhotoOne"
        static let groupUserPhotoSecondName = "FriendPhotoSecond"
        static let groupUserPhotoThirdName = "FriendPhotoThird"
        static let groupUserNameOneName = "Питание"
        static let groupUserNameSecondName = "Спорт"
        static let groupUserNameThirdName = "Путешествия"
    }

    // MARK: - Private Properties

    private var groups = [
        Group(groupName: Constants.groupUserNameOneName, groupPhotoName: Constants.groupUserPhotoOneName),
        Group(groupName: Constants.groupUserNameSecondName, groupPhotoName: Constants.groupUserPhotoSecondName),
        Group(groupName: Constants.groupUserNameThirdName, groupPhotoName: Constants.groupUserPhotoThirdName),
        Group(groupName: Constants.groupUserNameOneName, groupPhotoName: Constants.groupUserPhotoOneName),
        Group(groupName: Constants.groupUserNameSecondName, groupPhotoName: Constants.groupUserPhotoSecondName),
        Group(groupName: Constants.groupUserNameThirdName, groupPhotoName: Constants.groupUserPhotoThirdName),
        Group(groupName: Constants.groupUserNameOneName, groupPhotoName: Constants.groupUserPhotoOneName),
        Group(groupName: Constants.groupUserNameSecondName, groupPhotoName: Constants.groupUserPhotoSecondName),
        Group(groupName: Constants.groupUserNameThirdName, groupPhotoName: Constants.groupUserPhotoThirdName),
        Group(groupName: Constants.groupUserNameOneName, groupPhotoName: Constants.groupUserPhotoOneName),
        Group(groupName: Constants.groupUserNameSecondName, groupPhotoName: Constants.groupUserPhotoSecondName),
        Group(groupName: Constants.groupUserNameThirdName, groupPhotoName: Constants.groupUserPhotoThirdName),
    ]

    // MARK: - Public Methods

    func returnGroup(index: Int) -> Group? {
        guard
            index < groups.count,
            index >= 0
        else { return nil }
        return groups[index]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView
            .dequeueReusableCell(
                withIdentifier: Constants.groupUserCellID,
                for: indexPath
            ) as? SearchGroupTableViewCell,
            indexPath.row < groups.count
        else { return UITableViewCell() }
        cell.configureCell(group: groups[indexPath.row])
        return cell
    }
}
