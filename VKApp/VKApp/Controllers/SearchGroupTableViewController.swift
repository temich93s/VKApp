// SearchGroupTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с поиска групп
final class SearchGroupTableViewController: UITableViewController {
    // MARK: - Constants

    private enum Constants {
        static let groupUserCellID = "SearchGroupCell"
        static let groupsSearchText = "groups.search"
        static let qText = "q"
    }

    // MARK: - IBOutlet

    @IBOutlet private var searchGroupSearchBar: UISearchBar!

    // MARK: - Private Properties

    private var groups: [Group] = []
    private var allGroups: [Group] = []
    private var items: [ItemGroupVK] = []
    private let vkNetworkService = VKNetworkService()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Public Methods

    func returnGroup(index: Int) -> Group? {
        guard
            index < groups.count,
            index >= 0
        else { return nil }
        return groups[index]
    }

    func configureSearchGroupTableVC(groups: [Group]) {
        allGroups = groups
        self.groups = allGroups
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
        cell.configure(group: groups[indexPath.row])
        return cell
    }

    // MARK: - Private Methods

    private func setupView() {
        searchGroupSearchBar.delegate = self
    }
}

// MARK: - UISearchBarDelegate

extension SearchGroupTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        groups = allGroups
        if searchText.isEmpty {
            searchBar.endEditing(true)
        } else {
            vkNetworkService.sendRequestGroupVK(
                method: Constants.groupsSearchText,
                parameterMap: [Constants.qText: searchText]
            ) { [weak self] items in
                self?.items = items
                for item in items {
                    self?.groups.append(Group(groupName: item.name, groupPhotoName: item.photo200))
                }
                self?.tableView.reloadData()
            }
        }
        tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
