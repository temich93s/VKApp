// GroupUserTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с группами пользователя
final class GroupUserTableViewController: UITableViewController {
    // MARK: - Constants

    private enum Constants {
        static let segueID = "GoToSearchGroupTableVC"
        static let groupUserCellID = "GroupUserCell"
        static let addGroupSegueID = "AddGroup"
        static let groupUserPhotoOneName = "FriendPhotoOne"
        static let groupUserPhotoSecondName = "FriendPhotoSecond"
        static let groupUserPhotoThirdName = "FriendPhotoThird"
        static let groupUserNameOneName = "Новости"
        static let groupUserNameSecondName = "Программирование"
        static let groupUserNameThirdName = "Отдых"
        static let groupUserNameFourName = "Питание"
        static let groupUserNameFiveName = "Спорт"
        static let groupUserNameSixName = "Путешествия"
    }

    // MARK: - IBAction

    @IBAction func addGroup(segue: UIStoryboardSegue) {
        guard
            segue.identifier == Constants.addGroupSegueID,
            let source = segue.source as? SearchGroupTableViewController,
            let indexPath = source.tableView.indexPathForSelectedRow,
            let group = source.returnGroup(index: indexPath.row),
            !userGroups.contains(group)
        else { return }
        for (index, groupFromAllGroups) in allGroups.enumerated() {
            guard group == groupFromAllGroups else { continue }
            allGroups.remove(at: index)
        }
        userGroups.append(group)
        tableView.reloadData()
    }

    // MARK: - Private Properties

    private var allGroups = [
        Group(groupName: Constants.groupUserNameFourName, groupPhotoName: Constants.groupUserPhotoOneName),
        Group(groupName: Constants.groupUserNameFiveName, groupPhotoName: Constants.groupUserPhotoSecondName),
        Group(groupName: Constants.groupUserNameSixName, groupPhotoName: Constants.groupUserPhotoThirdName)
    ]

    private var userGroups = [
        Group(groupName: Constants.groupUserNameOneName, groupPhotoName: Constants.groupUserPhotoOneName),
        Group(groupName: Constants.groupUserNameSecondName, groupPhotoName: Constants.groupUserPhotoSecondName),
        Group(groupName: Constants.groupUserNameThirdName, groupPhotoName: Constants.groupUserPhotoThirdName)
    ]

    // MARK: - Public Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView
            .dequeueReusableCell(
                withIdentifier: Constants.groupUserCellID,
                for: indexPath
            ) as? GroupUserTableViewCell,
            indexPath.row < userGroups.count
        else { return UITableViewCell() }
        cell.configureCell(group: userGroups[indexPath.row])
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            allGroups.append(userGroups.remove(at: indexPath.row))
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == Constants.segueID,
            let destination = segue.destination as? SearchGroupTableViewController
        else { return }
        destination.configureSearchGroupTableVC(groups: allGroups)
    }
}
