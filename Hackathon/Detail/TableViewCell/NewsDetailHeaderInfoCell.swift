//
//  NewsDetailHeaderInfoCell.swift
//  Hackathon sample app
//
//  Created by Arige Maheswari (Digital Business - Technology- Visakhapatnam) on 19/11/24.
//

import UIKit

class NewsDetailHeaderInfoCell: UITableViewCell {
    
    @IBOutlet weak var headLineLabel: UILabel!
    @IBOutlet weak var timeReadLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(headLine: String?, postTime: String?) {
        self.headLineLabel.text = headLine
        let time = Date.timeFromDate(dateString: postTime ?? "")
        self.timeReadLabel.text = self.getHTDataPostTimeAndTimeToRead(postTime: time, timeToRead: "0")
    }
}
