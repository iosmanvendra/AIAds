//
//  NewsDetailCollectionCell.swift
//  Hackathon sample app
//
//  Created by Arige Maheswari (Digital Business - Technology- Visakhapatnam) on 19/11/24.
//

import UIKit

class NewsDetailCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var adImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(ad: CustomAdModel?) {
        self.titleLabel.text = ad?.title
        self.subTitleLabel.text = ad?.subTitle
        self.adImageView.sd_setImage(with: URL(string: ad?.bannerUrl ?? ""), placeholderImage: UIImage(named: "placeholder"))
    }
}
