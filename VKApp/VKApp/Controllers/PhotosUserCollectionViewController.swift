// PhotosUserCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// Экран с фотографиями пользователя
final class PhotosUserCollectionViewController: UICollectionViewController {
    // MARK: - Constants

    private enum Constants {
        static let photosUserCellID = "PhotosUserCell"
        static let friendPhotoOneName = "FriendPhotoOne"
        static let emptyText = ""
    }

    // MARK: - Private Properties

    private var user = User(userName: Constants.emptyText, userPhotoName: Constants.emptyText)

    // MARK: - Public Methods

    func configurePhotosUserCollectionVC(currentUser: User) {
        user = currentUser
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constants.photosUserCellID,
                for: indexPath
            ) as? PhotosUserCollectionViewCell
        else { return UICollectionViewCell() }
        cell.configureCell(userPhoto: user.userPhotoName)
        return cell
    }
}
