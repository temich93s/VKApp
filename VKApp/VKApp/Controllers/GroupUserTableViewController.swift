// GroupUserTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import UIKit

/// Экран с группами пользователя
final class GroupUserTableViewController: UITableViewController {
    // MARK: - Constants

    private enum Constants {
        static let segueID = "GoToSearchGroupTableVC"
        static let groupUserCellID = "GroupUserCell"
        static let addGroupSegueID = "AddGroup"
    }

    // MARK: - Private Properties

    private let vkNetworkService = VKNetworkService()
    private let realmService = RealmService()

    private var vkGroups: [VKGroups] = []
    private var notificationToken: NotificationToken?
    private var groupsResults: Results<VKGroups>?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Public Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groupsResults?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView
            .dequeueReusableCell(
                withIdentifier: Constants.groupUserCellID,
                for: indexPath
            ) as? GroupUserTableViewCell,
            let groupsResults = groupsResults,
            indexPath.row < groupsResults.count
        else { return UITableViewCell() }
        cell.configure(group: groupsResults[indexPath.row])
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            realmService.deleteGroupVKData(vkGroups.remove(at: indexPath.row))
        }
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
            !vkGroups.contains(group)
        else { return }
        vkGroups.append(group)
        realmService.saveGroupVKData(vkGroups)
    }

    // MARK: - Private Methods

    private func setupView() {
        setupNotificationToken()
        loadFromRealm()
        loadFromNetwork()
    }

    private func loadFromRealm() {
        do {
            let realm = try Realm()
            groupsResults = realm.objects(VKGroups.self)
            guard let groupsResults = groupsResults else { return }
            vkGroups = Array(groupsResults)
        } catch {}
        tableView.reloadData()
    }

    private func loadFromNetwork() {
        vkNetworkService.fetchUserGroupsVK { [weak self] in
            guard let self = self else { return }
            self.loadFromRealm()
        }
    }

    private func setupNotificationToken() {
        do {
            let realm = try Realm()
            groupsResults = realm.objects(VKGroups.self)
        } catch {}
        guard let groupsResults = groupsResults else { return }
        notificationToken = groupsResults.observe { [weak self] (changes: RealmCollectionChange) in
            guard let self = self else { return }
            switch changes {
            case .initial:
                self.tableView.reloadData()
            case let .update(_, deletions, insertions, modifications):
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.reloadRows(
                    at: modifications.map { IndexPath(row: $0, section: 0) },
                    with: .automatic
                )
                self.tableView.endUpdates()
            case .error: break
            }
        }
    }
}
