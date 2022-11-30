// FriendsUserViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import UIKit

// MARK: - typealias

typealias CharacterHandler = (Character) -> ()

/// Экран с друзьями пользователя
final class FriendsUserViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let friendsUserCellID = "FriendsUserCell"
        static let segueID = "GoToPhotosUserCollectionVC"
        static let whiteColorName = "WhiteColor"
        static let darkBlueColorName = "DarkBlueColor"
    }

    // MARK: - IBOutlet

    @IBOutlet private var characterSetControl: CharacterSetControl!
    @IBOutlet private var friendsTableView: UITableView!
    @IBOutlet private var friendsSearchBar: UISearchBar!

    // MARK: - Private Properties

    private let vkNetworkService = VKNetworkService()
    private let realmService = RealmService()

    private var friendsForSectionMap: [Character: [ItemPerson]] = [:]
    private var charactersName: [Character] = []
    private var itemPersons: [ItemPerson] = []
    private var allFriends: [ItemPerson] = []
    private var notificationToken: NotificationToken?
    private var friendsResults: Results<ItemPerson>?

    private lazy var scrollFromCharacterHandler: CharacterHandler? = { [weak self] character in
        guard
            let self = self,
            let section = self.charactersName.firstIndex(of: character)
        else { return }
        let indexPath = IndexPath(row: 0, section: section)
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
        friendsSearchBar.delegate = self
        setupCharacters()
        makeFriendsForSection()
        itemPersons.sort { $0.fullName < $1.fullName }
        characterSetControl.scrollFromCharacterHandler = scrollFromCharacterHandler
        setupNotificationToken()
        loadData()
    }

    private func loadData() {
        guard let resultsItemPerson = realmService.loadData(objectType: ItemPerson.self) else { return }
        let persons = Array(resultsItemPerson)
        itemPersons = persons
        setupUI(persons: itemPersons)
        fetchFriendsVK()
    }

    private func setupCharacters() {
        charactersName = []
        for friend in itemPersons {
            guard
                !friend.fullName.isEmpty,
                let safeChatacter = friend.fullName.first,
                !charactersName.contains(safeChatacter)
            else { continue }
            charactersName.append(safeChatacter)
        }
        charactersName.sort()
        characterSetControl.characterSet = charactersName
    }

    private func makeFriendsForSection() {
        for character in charactersName {
            var friendsForCharacter: [ItemPerson] = []
            for friend in itemPersons {
                guard
                    !friend.fullName.isEmpty,
                    let safeChatacter = friend.fullName.first,
                    character == safeChatacter
                else { continue }
                friendsForCharacter.append(friend)
            }
            friendsForSectionMap[character] = friendsForCharacter
        }
    }

    private func fetchFriendsVK() {
        vkNetworkService.fetchFriendsVK { [weak self] in
            guard let self = self,
                  let resultsItemPerson = self.realmService.loadData(objectType: ItemPerson.self)
            else { return }
            let persons = Array(resultsItemPerson)
            self.itemPersons = persons
            self.setupUI(persons: self.itemPersons)
        }
    }

    private func setupUI(persons: [ItemPerson]) {
        allFriends = persons
        itemPersons = persons
        setupCharacters()
        makeFriendsForSection()
        itemPersons.sort { $0.fullName < $1.fullName }
        characterSetControl.scrollFromCharacterHandler = scrollFromCharacterHandler
        friendsTableView.reloadData()
    }

    private func setupNotificationToken() {
        guard let friendsResults = realmService.loadData(objectType: ItemPerson.self) else { return }
        notificationToken = friendsResults.observe { [weak self] (changes: RealmCollectionChange) in
            guard let self = self else { return }
            switch changes {
            case .initial:
                self.friendsTableView.reloadData()
            case let .update(_, deletions, insertions, modifications):
                self.friendsTableView.beginUpdates()
                self.friendsTableView.insertRows(
                    at: insertions.map { IndexPath(row: $0, section: 0) },
                    with: .automatic
                )
                self.friendsTableView.deleteRows(
                    at: deletions.map { IndexPath(row: $0, section: 0) },
                    with: .automatic
                )
                self.friendsTableView.reloadRows(
                    at: modifications.map { IndexPath(row: $0, section: 0) },
                    with: .automatic
                )
                self.friendsTableView.endUpdates()
            case .error: break
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension FriendsUserViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        charactersName.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard
            section < charactersName.count,
            let countFriendsForSection = friendsForSectionMap[charactersName[section]]?.count
        else { return 0 }
        return countFriendsForSection
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView
            .dequeueReusableCell(
                withIdentifier: Constants.friendsUserCellID,
                for: indexPath
            ) as? FriendsUserTableViewCell,
            indexPath.row < itemPersons.count,
            indexPath.section < charactersName.count,
            let friendsForSectionMap = friendsForSectionMap[charactersName[indexPath.section]]
        else { return UITableViewCell() }
        cell.configure(user: friendsForSectionMap[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section < charactersName.count else { return nil }
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        let label = UILabel()
        headerView.backgroundColor = UIColor(named: Constants.darkBlueColorName)?.withAlphaComponent(0.5)
        label.frame = CGRect(x: 19, y: 5, width: headerView.frame.width - 38, height: headerView.frame.height - 10)
        label.text = "\(charactersName[section])"
        label.font = .systemFont(ofSize: 18)
        label.textColor = UIColor(named: Constants.whiteColorName)
        headerView.addSubview(label)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        30
    }
}

// MARK: - UISearchBarDelegate

extension FriendsUserViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        itemPersons = allFriends
        if searchText.isEmpty {
            searchBar.endEditing(true)
        } else {
            itemPersons = itemPersons.filter { user in
                user.fullName.range(of: searchText, options: .caseInsensitive) != nil
            }
        }
        setupCharacters()
        makeFriendsForSection()
        friendsTableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
