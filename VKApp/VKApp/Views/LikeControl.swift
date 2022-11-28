// LikeControl.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Контрол который позволяет поставить лайк
@IBDesignable final class LikeControl: UIControl {
    // MARK: - Constants

    private enum Constants {
        static let heartText = "heart"
        static let heartFillText = "heart.fill"
        static let lightBlueColorName = "LightBlueColor"
        static let redColorName = "RedColor"
    }

    // MARK: - Private Visual Properties

    private var stackView: UIStackView!

    private lazy var countLikeLabel: UILabel = {
        let label = UILabel()
        label.text = "\(likeCount)"
        label.textAlignment = .center
        label.textColor = UIColor(named: Constants.lightBlueColorName)
        return label
    }()

    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Constants.heartText), for: .normal)
        button.tintColor = UIColor(named: Constants.lightBlueColorName)
        button.addTarget(self, action: #selector(selectLikeAction(_:)), for: .touchUpInside)
        return button
    }()

    // MARK: - Public Properties

    var likeCount = 0

    // MARK: - Private Properties

    private var islikePressed = false

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

    @objc private func selectLikeAction(_ sender: UIButton) {
        animateCountLikeLabel()
        likeCount = islikePressed ? likeCount - 1 : likeCount + 1
        countLikeLabel.textColor = islikePressed ?
            UIColor(named: Constants.lightBlueColorName) :
            UIColor(named: Constants.redColorName)
        if islikePressed {
            likeButton.setImage(UIImage(systemName: Constants.heartText), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: Constants.heartFillText), for: .normal)
        }
        likeButton.tintColor = islikePressed ? .blue : .red
        countLikeLabel.text = "\(likeCount)"
        islikePressed.toggle()
    }

    private func setupView() {
        stackView = UIStackView(arrangedSubviews: [countLikeLabel, likeButton])
        addSubview(stackView)
        stackView.spacing = 1
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
    }

    private func animateCountLikeLabel() {
        UIView.animate(withDuration: 1) {
            self.countLikeLabel.transform = self.countLikeLabel.transform.rotated(by: CGFloat.pi)
            self.countLikeLabel.transform = self.countLikeLabel.transform.rotated(by: CGFloat.pi)
            self.countLikeLabel.frame.origin.y += 100
        }
    }
}
