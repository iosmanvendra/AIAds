//
//  NewsDetailRelatedProductAdCell.swift
//  Hackathon sample app
//
//  Created by Arige Maheswari (Digital Business - Technology- Visakhapatnam) on 19/11/24.
//

import UIKit

protocol NewsDetailProductAdCellDelegate: AnyObject {
    func didTapBuyButton()
}

class NewsDetailRelatedProductAdCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var buyButton: UIButton!
    
    weak var delegate: NewsDetailProductAdCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure() {
        self.productImageView.sd_setImage(with: nil, placeholderImage: UIImage(named: "placeholder"))
    }
    
    @IBAction func buyButtonTapped(_ sender: Any) {
        self.delegate?.didTapBuyButton()
    }
}
