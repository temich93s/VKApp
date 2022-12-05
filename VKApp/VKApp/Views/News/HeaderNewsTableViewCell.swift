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
        nameAuthorLabel.text = "\(news.sourceID)"
        let date = Date(timeIntervalSinceReferenceDate: Double(news.date))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        dateNewsAuthorLabel.text = dateFormatter.string(from: date)
    }
}
