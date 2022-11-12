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

    // MARK: - IBOutlet

    @IBOutlet private var searchGroupSearchBar: UISearchBar!

    // MARK: - Private Properties

    private var groups: [Group] = []
    private var allGroups: [Group] = []

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
            groups = groups.filter { group in
                group.groupName.range(of: searchText, options: .caseInsensitive) != nil
            }
        }
        tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
