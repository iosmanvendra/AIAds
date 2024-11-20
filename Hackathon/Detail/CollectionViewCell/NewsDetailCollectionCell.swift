//
//  NewsDetailCollectionCell.swift
//  Hackathon sample app
//
//  Created by Arige Maheswari (Digital Business - Technology- Visakhapatnam) on 19/11/24.
//

import UIKit

class NewsDetailCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(text: String) {
        self.titleLabel.text = text
    }
}
