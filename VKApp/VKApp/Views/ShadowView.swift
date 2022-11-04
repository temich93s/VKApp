// ShadowView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Круг с тенью
@IBDesignable final class ShadowView: UIView {
    // MARK: - Public Properties

    @IBInspectable var shadowColor: UIColor = .black {
        didSet {
            updateShadowColor()
        }
    }

    @IBInspectable var shadowOpacity: CGFloat = 1 {
        didSet {
            updateShadowOpacity()
        }
    }

    @IBInspectable var shadowRadius: CGFloat = 50 {
        didSet {
            self.updateShadowRadius()
        }
    }

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    // MARK: - Private Methods

    private func updateShadowColor() {
        layer.shadowColor = shadowColor.cgColor
    }

    private func updateShadowOpacity() {
        layer.shadowOpacity = Float(shadowOpacity)
    }

    private func updateShadowRadius() {
        layer.shadowRadius = shadowRadius
    }

    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = frame.width / 2
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize.zero
        layer.masksToBounds = false
    }
}
