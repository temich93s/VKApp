// SearchGroupTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import UIKit

/// Экран с поиска групп
final class SearchGroupTableViewController: UITableViewController {
    // MARK: - Constants

    private enum Constants {
        static let groupUserCellID = "SearchGroupCell"
    }

    // MARK: - IBOutlet

    @IBOutlet private var searchGroupSearchBar: UISearchBar!

    // MARK: - Private Properties

    private let vkNetworkService = VKNetworkService()
    private var searchGroups: [VKGroups] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Public Methods

    func returnGroup(index: Int) -> VKGroups? {
        guard
            index < searchGroups.count,
            index >= 0
        else { return nil }
        return searchGroups[index]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView
            .dequeueReusableCell(
                withIdentifier: Constants.groupUserCellID,
                for: indexPath
            ) as? SearchGroupTableViewCell,
            indexPath.row < searchGroups.count
        else { return UITableViewCell() }
        cell.configure(group: searchGroups[indexPath.row], vkNetworkService: vkNetworkService)
        return cell
    }

    // MARK: - Private Methods

    private func setupView() {
        searchGroupSearchBar.delegate = self
    }
}

// MARK: - UISearchBarDelegate

extension SearchGroupTableViewController: UISearchBarDelegate {
    // MARK: - Public Methods

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchGroup(searchBar: searchBar, searchText: searchText)
        tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

    func searchGroup(searchBar: UISearchBar, searchText: String) {
        if searchText.isEmpty {
            searchBar.endEditing(true)
        } else {
            vkNetworkService.fetchSearchGroupsVK(searchText: searchText) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .fulfilled(response):
                    self.searchGroups = response
                    self.tableView.reloadData()
                case let .rejected(error):
                    self.showErrorAlert(alertTitle: nil, message: error.localizedDescription, actionTitle: nil)
                }
            }
        }
    }
}
