// FooterNewsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///
final class FooterNewsTableViewCell: UITableViewCell {
    @IBOutlet var likeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(news: Newsfeed) {
        likeLabel.text = "\(news.likes?.count ?? 0)"
    }
}
