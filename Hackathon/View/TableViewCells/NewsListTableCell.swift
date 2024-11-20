//
//  NewsListTableCell.swift
//  Hackathon sample app
//
//  Created by Arige Maheswari (Digital Business - Technology- Visakhapatnam) on 18/11/24.
//

import UIKit
import SDWebImage

class NewsListTableCell: UITableViewCell {
    
    var item: NewsItem?
    
    @IBOutlet weak var economistLogoView: UIImageView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var separaterBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var liveblogView: UIImageView!
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var photoNewsView: UIView!
    @IBOutlet weak var imageCountLabel: UILabel!
    @IBOutlet weak var separater: UIView!
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var sponsoredLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var exclusiveImageView: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var btnbookmark: UIButton!
    @IBOutlet weak var lblSectionName: UILabel!
    @IBOutlet weak var timeToReadLeadingConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.headlineLabel.numberOfLines = 3
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(item:NewsItem) {
        self.item = item
        
        economistLogoView.isHidden = true
        liveblogView.isHidden = true
        self.exclusiveImageView.isHidden = true
        self.featuredImageView.isHidden = true
//        
        self.headlineLabel.text = item.headLine//.removeUnsupportedTags()
        let displayTime = Date.timeFromDate(dateString: item.publishedDate ?? "")
        self.timeLabel.text = self.getHTDataPostTimeAndTimeToRead(postTime: displayTime, timeToRead: String(item.timeToRead ?? 0)) //item.displayTime
        self.sponsoredLabel.isHidden = true
        lblSectionName.text = item.section

        if lblSectionName.text?.isEmpty ?? true {
            timeToReadLeadingConstraint.constant = 0
        } else {
            timeToReadLeadingConstraint.constant = 12
        }
        
        var img = item.thumbImage ?? ""
        if img.isEmpty {
            img = item.mediumRes ?? ""
        }
        if img.isEmpty {
            img = item.wallpaperLarge ?? ""
        }

        self.newsImageView.sd_setImage(with: URL(string: img), placeholderImage: UIImage(named: "placeholder"))
    }
    @IBAction func shareButtonAction(_ sender: UIButton) {
        
    }
    
    @IBAction func btnBookmarkTapped(_ sender: UIButton) {
//        if let currentItem = self.item {
//            self.delegate?.removeBookmark(item: currentItem, btn: sender)
//        }
    }
}
