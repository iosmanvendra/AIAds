//
//  NewsDetailTopAdCell.swift
//  Hackathon sample app
//
//  Created by Arige Maheswari (Digital Business - Technology- Visakhapatnam) on 19/11/24.
//

import UIKit

class NewsDetailTopAdCell: UITableViewCell {
    
    @IBOutlet weak var adImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(adUrl: String?) {
        self.adImageView.sd_setImage(with: URL(string: adUrl ?? ""))
    }
}
