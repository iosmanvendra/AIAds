//
//  NewsDetailRelatedProductAdCell.swift
//  Hackathon sample app
//
//  Created by Arige Maheswari (Digital Business - Technology- Visakhapatnam) on 19/11/24.
//

import UIKit

protocol NewsDetailProductAdCellDelegate: AnyObject {
    func adTapped(ad: CustomAdModel?)
}

class NewsDetailRelatedProductAdCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var buyButton: UIButton!
    
    var ad: CustomAdModel?
    weak var delegate: NewsDetailProductAdCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(ad: CustomAdModel?) {
        self.titleLabel.text = ad?.title
        self.descriptionLabel.text = ad?.subTitle
        self.productImageView.sd_setImage(with: URL(string: ad?.bannerUrl ?? ""), placeholderImage: UIImage(named: "placeholder"))
    }
    
    @IBAction func buyButtonTapped(_ sender: Any) {
        self.delegate?.adTapped(ad: ad)
    }
}
