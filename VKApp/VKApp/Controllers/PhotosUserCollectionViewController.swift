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
        static let GoToBigPhotosUserVCSegueID = "GoToBigPhotosUserVC"
    }

    // MARK: - Private Properties

    private var user = User(
        userName: Constants.emptyText,
        userPhotoName: Constants.emptyText,
        userPhotosName: [""],
        id: 0
    )

    private var currentIndexPressedCell = 0

    private let vkService = VKService()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Public Methods

    func configurePhotosUserCollectionVC(currentUser: User) {
        user = currentUser
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        user.userPhotosName.count
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
            indexPath.row < user.userPhotosName.count
        else { return UICollectionViewCell() }
        cell.configure(userPhoto: user.userPhotosName[indexPath.row])
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
            currentUserPhotoIndex: currentIndexPressedCell,
            userPhotosName: user.userPhotosName
        )
    }

    // MARK: - Private Methods

    private func setupView() {
        vkService.sendRequestPhotos(
            method: "photos.getAll",
            parameterMap: ["owner_id": "\(user.id)"]
        ) { [weak self] photosURLText in
            self?.user.userPhotosName = photosURLText
            self?.collectionView.reloadData()
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
        currentIndexPressedCell = indexPath.row
        performSegue(withIdentifier: Constants.GoToBigPhotosUserVCSegueID, sender: self)
    }
}
