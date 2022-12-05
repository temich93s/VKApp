// HeaderNewsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///
class HeaderNewsTableViewCell: UITableViewCell {
    @IBOutlet var imageAuthorImageView: UIImageView!
    @IBOutlet var nameAuthorLabel: UILabel!
    @IBOutlet var dateNewsAuthorLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func configure(news: Newsfeed) {
        nameAuthorLabel.text = "\(news.sourceID ?? 0)"
        dateNewsAuthorLabel.text = "\(news.date ?? 0)"
    }
}
