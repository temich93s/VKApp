// PhotoNewsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///
class PhotoNewsTableViewCell: UITableViewCell {
    @IBOutlet var photoImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        photoImageView.image = nil
    }

    func configure(news: Newsfeed, networkService: VKNetworkService) {
        photoImageView.setupImage(urlPath: news.photos?.items.first?.sizes.last?.url, networkService: networkService)
    }
}
