// GroupUserTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import PromiseKit
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
    private let animationService = AnimationService()

    private var vkGroups: [VKGroups] = []
    private var notificationToken: NotificationToken?
    private var groupsResults: Results<VKGroups>?
    private var photoService: PhotoService?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Public Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vkGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView
            .dequeueReusableCell(
                withIdentifier: Constants.groupUserCellID,
                for: indexPath
            ) as? GroupUserTableViewCell,
            indexPath.row < vkGroups.count
        else { return UITableViewCell() }
        cell.configure(group: vkGroups[indexPath.row], photoService: photoService, row: indexPath.row)
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
        cell.animateGroupPhotoImageView(animationService: animationService)
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
        photoService = PhotoService(container: self)
        setupNotificationToken()
        loadData()
    }

    private func loadData() {
        tableView.reloadData()
        getUserGroupsVK()
    }

    private func getUserGroupsVK() {
        firstly {
            vkNetworkService.fetchDataUserGroupsVK()
        }.then { data in
            self.vkNetworkService.parseUserGroupsVK(data: data)
        }.done { vkGroups in
            self.realmService.saveGroupVKData(vkGroups)
            guard let resultsVkGroups = self.realmService.loadData(objectType: VKGroups.self) else { return }
            self.vkGroups = Array(resultsVkGroups)
            self.tableView.reloadData()
        }.catch { error in
            self.showErrorAlert(alertTitle: nil, message: error.localizedDescription, actionTitle: nil)
        }
    }

    private func setupNotificationToken() {
        guard let groupsResults = realmService.loadData(objectType: VKGroups.self) else { return }
        notificationToken = groupsResults.observe { [weak self] (changes: RealmCollectionChange) in
            guard let self = self else { return }
            self.vkGroups = Array(groupsResults)
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
