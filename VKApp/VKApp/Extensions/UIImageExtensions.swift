// UIImageExtensions.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Добавление установки изображения из сети в UIImageView
extension UIImageView {
    // MARK: - Public Methods

    func setupImage(urlPath: String?) {
        guard
            let urlPath = urlPath,
            let url = URL(string: urlPath)
        else { return }
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                guard let data = data else { return }
                self.image = UIImage(data: data)
            }
        }
    }
}
