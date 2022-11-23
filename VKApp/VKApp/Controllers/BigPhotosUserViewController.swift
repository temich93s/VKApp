// BigPhotosUserViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран просмотра фотографий в большом виде
final class BigPhotosUserViewController: UIViewController {
    // MARK: - Private Outlets

    @IBOutlet private var currentUserPhotoImageView: UIImageView!
    @IBOutlet private var nextUserPhotoImageView: UIImageView!
    @IBOutlet private var currentUserPhotoTrailingConstraint: NSLayoutConstraint!
    @IBOutlet private var currentUserPhotoLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private var nextUserPhotoLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private var nextUserPhotoTrailingConstraint: NSLayoutConstraint!

    // MARK: - Private Properties

    private var userPhotoNames: [String] = []
    private var currentUserPhotoIndex = 0

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Public Methods

    func configureBigPhotosUserVC(currentUserPhotoIndex: Int, userPhotosName: [String]) {
        userPhotoNames = userPhotosName
        self.currentUserPhotoIndex = currentUserPhotoIndex
    }

    // MARK: - Private Methods

    @objc private func didSwipeAction(gesture: UIGestureRecognizer) {
        guard let swipeGesture = gesture as? UISwipeGestureRecognizer else { return }
        switch swipeGesture.direction {
        case .right:
            guard
                currentUserPhotoIndex < userPhotoNames.count,
                currentUserPhotoIndex > 0
            else { return }
            doAnimationForSwipeRight()
        case .left:
            guard
                currentUserPhotoIndex < userPhotoNames.count - 1,
                currentUserPhotoIndex >= 0
            else { return }
            doAnimationForSwipeLeft()
        default:
            break
        }
    }

    private func doAnimationForSwipeLeft() {
        prepareForAnimationForSwipeLeft()
        UIView.animateKeyframes(withDuration: 0.6, delay: 0, options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                self.currentUserPhotoTrailingConstraint.constant = 50
                self.currentUserPhotoLeadingConstraint.constant = 50
                self.view.layoutIfNeeded()
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.view.layoutIfNeeded()
                self.nextUserPhotoTrailingConstraint.constant = 0
                self.nextUserPhotoLeadingConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }

    private func prepareForAnimationForSwipeLeft() {
        currentUserPhotoTrailingConstraint.constant = 0
        currentUserPhotoLeadingConstraint.constant = 0
        currentUserPhotoImageView.layer.zPosition = 1
        setCurrentUserPhotoImageView(userPhotoURLText: userPhotoNames[currentUserPhotoIndex])
        nextUserPhotoTrailingConstraint.constant = -view.frame.width
        nextUserPhotoLeadingConstraint.constant = view.frame.width
        nextUserPhotoImageView.layer.zPosition = 2
        setNextUserPhotoImageView(userPhotoURLText: userPhotoNames[currentUserPhotoIndex + 1])
        view.layoutIfNeeded()
        currentUserPhotoIndex += 1
    }

    private func doAnimationForSwipeRight() {
        prepareForAnimationForSwipeRight()
        UIView.animateKeyframes(withDuration: 0.6, delay: 0, options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                self.currentUserPhotoTrailingConstraint.constant = -self.view.frame.width
                self.currentUserPhotoLeadingConstraint.constant = self.view.frame.width
                self.view.layoutIfNeeded()
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.view.layoutIfNeeded()
                self.nextUserPhotoTrailingConstraint.constant = 0
                self.nextUserPhotoLeadingConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }

    private func prepareForAnimationForSwipeRight() {
        currentUserPhotoTrailingConstraint.constant = 0
        currentUserPhotoLeadingConstraint.constant = 0
        currentUserPhotoImageView.layer.zPosition = 2
        setCurrentUserPhotoImageView(userPhotoURLText: userPhotoNames[currentUserPhotoIndex])
        nextUserPhotoTrailingConstraint.constant = 50
        nextUserPhotoLeadingConstraint.constant = 50
        nextUserPhotoImageView.layer.zPosition = 1
        setNextUserPhotoImageView(userPhotoURLText: userPhotoNames[currentUserPhotoIndex - 1])
        view.layoutIfNeeded()
        currentUserPhotoIndex -= 1
    }

    private func setupView() {
        addSwipeToView()
        setupImageViews()
    }

    private func setupImageViews() {
        guard 0 ..< userPhotoNames.count ~= currentUserPhotoIndex else { return }
        setCurrentUserPhotoImageView(userPhotoURLText: userPhotoNames[currentUserPhotoIndex])
    }

    private func addSwipeToView() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeAction(gesture:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        let swipeRigth = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeAction(gesture:)))
        swipeRigth.direction = .right
        view.addGestureRecognizer(swipeRigth)
    }

    private func setNextUserPhotoImageView(userPhotoURLText: String) {
        let url = URL(string: userPhotoURLText)
        DispatchQueue.global().async {
            guard let url = url else { return }
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                guard let data = data else { return }
                self.nextUserPhotoImageView.image = UIImage(data: data)
            }
        }
    }

    private func setCurrentUserPhotoImageView(userPhotoURLText: String) {
        let url = URL(string: userPhotoURLText)
        DispatchQueue.global().async {
            guard let url = url else { return }
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                guard let data = data else { return }
                self.currentUserPhotoImageView.image = UIImage(data: data)
            }
        }
    }
}
