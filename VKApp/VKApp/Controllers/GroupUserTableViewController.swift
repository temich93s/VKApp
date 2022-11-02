// GroupUserTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с группами пользователя
final class GroupUserTableViewController: UITableViewController {
    // MARK: - Constants

    private enum Constants {
        static let groupUserCellID = "GroupUserCell"
        static let addGroupSegueID = "AddGroup"
        static let groupUserPhotoOneName = "FriendPhotoOne"
        static let groupUserPhotoSecondName = "FriendPhotoSecond"
        static let groupUserPhotoThirdName = "FriendPhotoThird"
        static let groupUserNameOneName = "Новости"
        static let groupUserNameSecondName = "Программирование"
        static let groupUserNameThirdName = "Отдых"
    }

    // MARK: - IBAction

    @IBAction func addGroup(segue: UIStoryboardSegue) {
        guard
            segue.identifier == Constants.addGroupSegueID,
            let source = segue.source as? SearchGroupTableViewController,
            let indexPath = source.tableView.indexPathForSelectedRow,
            let group = source.returnGroup(index: indexPath.row),
            !groups.contains(group)
        else { return }
        groups.append(group)
        tableView.reloadData()
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView
            .dequeueReusableCell(
                withIdentifier: Constants.groupUserCellID,
                for: indexPath
            ) as? GroupUserTableViewCell,
            indexPath.row < groups.count
        else { return UITableViewCell() }
        cell.configureCell(group: groups[indexPath.row])
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
