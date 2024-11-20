//
//  NewsDetailImageCaptionCell.swift
//  Hackathon sample app
//
//  Created by Arige Maheswari (Digital Business - Technology- Visakhapatnam) on 19/11/24.
//

import UIKit

class NewsDetailImageCaptionCell: UITableViewCell {
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(imgStr: String, caption: String?) {
        self.newsImageView.sd_setImage(with: URL(string: imgStr), placeholderImage: UIImage(named: "placeholder"))
        captionLabel.text = caption
    }
}
