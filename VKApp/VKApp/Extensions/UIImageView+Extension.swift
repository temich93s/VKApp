// UIImageView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIImageView {
    func setupImage(urlPath: String?, networkService: VKNetworkService) {
        networkService.loadData(urlPath: urlPath) { [weak self] data in
            guard
                let self = self,
                let data = data
            else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
    }
}
