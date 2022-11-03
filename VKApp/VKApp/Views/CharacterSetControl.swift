// CharacterSetControl.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Контрол который содержит кликабельные буквы и перемещает список друзей по кликнутой букве
@IBDesignable final class CharacterSetControl: UIControl {
    // MARK: - Private Visual Properties

    private var buttons: [UIButton] = []
    private var stackView: UIStackView!

    // MARK: - Public Properties

    var characterSet: [Character] = ["a", "b", "c", "d"] {
        didSet {
            self.updateCharacterSet()
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

    // MARK: - Public Methods

    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }

    // MARK: - Private Methods

    @objc private func selectCharacterAction(_ sender: UIButton) {
        print("111")
    }

    // метод, отвечающий за создание UIStackView и кнопок:
    private func setupView() {
        for character in characterSet {
            let button = UIButton(type: .system)
            button.setTitle("\(character)", for: .normal)
            button.setTitleColor(.lightGray, for: .normal)
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

    // метод, который будет обновлять интерфейс в соответствии с выбранной кнопкой
    private func updateCharacterSet() {
//        for (index, button) in self.buttons.enumerated() {
//            guard let day = Day(rawValue: index) else { continue }
//            button.isSelected = day == self.selectedDay
//        }
    }
}
