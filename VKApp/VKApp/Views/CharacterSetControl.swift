// CharacterSetControl.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Контрол который содержит кликабельные буквы и перемещает список друзей по кликнутой букве
@IBDesignable final class CharacterSetControl: UIControl {
    // MARK: - Private Visual Properties

    private var buttons: [UIButton] = []
    private var stackView: UIStackView!

    // MARK: - Public Properties

    var characterSet: [Character] = [] {
        didSet {
            setupView()
        }
    }

    var scrollFromCharacterHandler: CharacterHandler?

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

    @objc private func selectCharacterAction(_ sender: UIButton) {
        for (index, button) in buttons.enumerated() {
            button.isSelected = sender.tag == index
        }
        guard sender.tag < characterSet.count else { return }
        scrollFromCharacterHandler?(characterSet[sender.tag])
    }

    private func setupView() {
        buttons.map { $0.removeFromSuperview() }
        buttons = []
        for (index, character) in characterSet.enumerated() {
            let button = UIButton(type: .system)
            button.tag = index
            button.setTitle("\(character)", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.setTitleColor(.white, for: .selected)
            button.addTarget(self, action: #selector(selectCharacterAction(_:)), for: .touchUpInside)
            buttons.append(button)
        }
        stackView = UIStackView(arrangedSubviews: buttons)
        addSubview(stackView)
        stackView.spacing = 1
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
    }
}
