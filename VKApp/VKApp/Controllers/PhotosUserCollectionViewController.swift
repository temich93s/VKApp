// PhotosUserCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import UIKit

/// Экран с фотографиями пользователя
final class PhotosUserCollectionViewController: UICollectionViewController {
    // MARK: - Constants

    private enum Constants {
        static let photosUserCellID = "PhotosUserCell"
        static let emptyText = ""
        static let GoToBigPhotosUserVCSegueID = "GoToBigPhotosUserVC"
    }

    // MARK: - Private Properties

    private let vkNetworkService = VKNetworkService()
    private var currentPerson = ItemPerson()
    private var pressedCellCurrentIndex = 0
    private var notificationToken: NotificationToken?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Public Methods

    func configurePhotosUserCollectionVC(currentUser: ItemPerson) {
        currentPerson = currentUser
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        currentPerson.photos.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constants.photosUserCellID,
                for: indexPath
            ) as? PhotosUserCollectionViewCell,
            indexPath.row < currentPerson.photos.count
        else { return UICollectionViewCell() }
        cell.configure(userPhoto: currentPerson.photos[indexPath.row].url)
        return cell
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        guard let cellPhotosUser = cell as? PhotosUserCollectionViewCell else { return }
        cellPhotosUser.animateShowFriendPhotoImageView()
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplaying cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        guard let cellPhotosUser = cell as? PhotosUserCollectionViewCell else { return }
        cellPhotosUser.animateHideFriendPhotoImageView()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == Constants.GoToBigPhotosUserVCSegueID,
            let destination = segue.destination as? BigPhotosUserViewController
        else { return }
        destination.configureBigPhotosUserVC(
            currentUserPhotoIndex: pressedCellCurrentIndex,
            userPhotosName: currentPerson.photos
        )
    }

    // MARK: - Private Methods

    private func setupView() {
        setupNotificationToken()
        loadFromRealm()
        fetchPhotosVK()
    }

    private func loadFromRealm() {
        do {
            let realm = try Realm()
            let persons = Array(realm.objects(ItemPerson.self))
            for person in persons where person.id == currentPerson.id {
                currentPerson = person
            }
            collectionView.reloadData()
        } catch {}
    }

    private func fetchPhotosVK() {
        vkNetworkService.fetchPhotosVK(person: createPersonForSave()) { [weak self] in
            guard let self = self else { return }
            self.loadFromRealm()
        }
    }

    private func createPersonForSave() -> ItemPerson {
        let person = ItemPerson()
        person.id = currentPerson.id
        person.photo = currentPerson.photo
        person.photos = currentPerson.photos
        person.firstName = currentPerson.firstName
        person.lastName = currentPerson.lastName
        return person
    }

    private func setupNotificationToken() {
        notificationToken = currentPerson.observe { [weak self] change in
            guard let self = self else { return }
            switch change {
            case .change, .deleted:
                self.loadFromRealm()
                self.collectionView.reloadData()
            case .error:
                break
            }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotosUserCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: (collectionView.bounds.width) / 3, height: (collectionView.bounds.width) / 3)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pressedCellCurrentIndex = indexPath.row
        performSegue(withIdentifier: Constants.GoToBigPhotosUserVCSegueID, sender: self)
    }
}
