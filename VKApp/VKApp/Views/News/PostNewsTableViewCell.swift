// PostNewsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///
class PostNewsTableViewCell: UITableViewCell {
    @IBOutlet var postTextView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func configure(news: Newsfeed) {
        postTextView.text = news.text
    }
}
