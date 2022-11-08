// NewsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с новостью
final class NewsTableViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let newsImageCollectionViewCellID = "NewsImageCollectionViewCell"
    }

    // MARK: - Private Outlets

    @IBOutlet private var userPhotoNameImageView: UIImageView!
    @IBOutlet private var userNameLabel: UILabel!
    @IBOutlet private var userNewsDateTextLabel: UILabel!
    @IBOutlet private var newsTextTextView: UITextView!
    @IBOutlet private var newsImagesCollectionView: UICollectionView!
    @IBOutlet private var newsLikeCountLabel: UILabel!

    // MARK: - Private Properties

    private var newsImagesName: [String] = []

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }

    // MARK: - Public Methods

    func configureCell(news: News, viewHight: CGFloat) {
        userPhotoNameImageView.image = UIImage(named: news.userPhotoName)
        userNameLabel.text = news.userName
        userNewsDateTextLabel.text = news.userNewsDateText
        newsTextTextView.text = news.newsText
        newsLikeCountLabel.text = "\(news.newsLikeCount)"
        newsImagesName = news.newsImagesName
        newsImagesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        newsImagesCollectionView.heightAnchor.constraint(equalToConstant: viewHight).isActive = true
    }

    // MARK: - Private Methods

    @objc private func userPhotoTappedAction(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            animateUserPhotoNameImageView()
        }
    }

    private func animateUserPhotoNameImageView() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.5
        animation.toValue = 1
        animation.stiffness = 100
        animation.mass = 2
        animation.duration = 1
        animation.beginTime = CACurrentMediaTime()
        animation.fillMode = CAMediaTimingFillMode.forwards
        userPhotoNameImageView.layer.add(animation, forKey: nil)
    }

    private func setupCell() {
        userPhotoNameImageView.layer.cornerRadius = userPhotoNameImageView.frame.height / 2
        newsImagesCollectionView.delegate = self
        newsImagesCollectionView.dataSource = self
        newsImagesCollectionView.register(
            UINib(nibName: Constants.newsImageCollectionViewCellID, bundle: nil),
            forCellWithReuseIdentifier: Constants.newsImageCollectionViewCellID
        )
        selectionStyle = .none
        let tap = UITapGestureRecognizer(target: self, action: #selector(userPhotoTappedAction))
        userPhotoNameImageView.addGestureRecognizer(tap)
        userPhotoNameImageView.isUserInteractionEnabled = true
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension NewsTableViewCell: UICollectionViewDelegateFlowLayout {}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension NewsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        newsImagesName.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constants.newsImageCollectionViewCellID,
                for: indexPath
            ) as? NewsImageCollectionViewCell,
            indexPath.row < newsImagesName.count
        else { return UICollectionViewCell() }
        cell.configureCell(newsImageName: newsImagesName[indexPath.row])
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        if newsImagesName.count == 1 {
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.width)
        } else {
            return CGSize(width: collectionView.bounds.width / 2, height: collectionView.bounds.width / 2)
        }
    }
}
