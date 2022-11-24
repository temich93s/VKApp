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

    // MARK: - Private Properties

    private var allGroups: [Group] = []

    private var userGroups: [Group] = []

    private let vkService = VKService()

    private var items: [ItemGroupVK] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

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
        cell.configure(group: userGroups[indexPath.row])
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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? GroupUserTableViewCell else { return }
        cell.animateGroupPhotoImageView()
    }

    // MARK: - IBAction

    @IBAction private func addGroupAction(segue: UIStoryboardSegue) {
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

    // MARK: - Private Methods

    private func setupView() {
        vkService.sendRequestGroupVK(
            method: "groups.get",
            parameterMap: ["user_id": "43832436", "extended": "1"]
        ) { [weak self] items in
            self?.items = items
            for item in items {
                self?.userGroups.append(Group(groupName: item.name, groupPhotoName: item.photo200))
            }
            print(self?.userGroups)
            self?.tableView.reloadData()
        }
    }
}
