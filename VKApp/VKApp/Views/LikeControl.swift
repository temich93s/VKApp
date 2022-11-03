// LikeControl.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Контрол который позволяет поставить лайк
@IBDesignable final class LikeControl: UIControl {
    // MARK: - Constants

    private enum Constants {
        static let heartText = "heart"
        static let heartFillText = "heart.fill"
    }

    // MARK: - Private Visual Properties

    private var stackView: UIStackView!

    private lazy var countLikeLabel: UILabel = {
        let label = UILabel()
        label.text = "\(countLike)"
        label.textAlignment = .center
        label.textColor = .blue
        return label
    }()

    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Constants.heartText), for: .normal)
        button.tintColor = .blue
        button.addTarget(self, action: #selector(selectLike(_:)), for: .touchUpInside)
        return button
    }()

    // MARK: - Public Properties

    var countLike = 0

    // MARK: - Private Properties

    private var likeWasPressed = false

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    // MARK: - Public Methods

    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }

    // MARK: - Private Methods

    @objc private func selectLike(_ sender: UIButton) {
        if likeWasPressed {
            likeWasPressed.toggle()
            countLike -= 1
            countLikeLabel.text = "\(countLike)"
            likeButton.setImage(UIImage(systemName: Constants.heartText), for: .normal)
            likeButton.tintColor = .blue
        } else {
            likeWasPressed.toggle()
            countLike += 1
            countLikeLabel.text = "\(countLike)"
            likeButton.setImage(UIImage(systemName: Constants.heartFillText), for: .normal)
            likeButton.tintColor = .red
        }
    }

    private func setupView() {
        stackView = UIStackView(arrangedSubviews: [countLikeLabel, likeButton])
        addSubview(stackView)
        stackView.spacing = 1
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
    }
}
