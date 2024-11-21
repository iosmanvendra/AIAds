//
//  NewsDetailParagraphCell.swift
//  Hackathon sample app
//
//  Created by Arige Maheswari (Digital Business - Technology- Visakhapatnam) on 19/11/24.
//

import UIKit

class NewsDetailParagraphCell: UITableViewCell {
    
    @IBOutlet weak var paragraphLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(para: String?) {
//        self.paragraphLabel.text = para
        loadHTMLToLabel(html: para)
    }
    
    func loadHTMLToLabel(html: String?) {
        // Convert the HTML string to Data
        guard let data = html?.data(using: .utf8) else { return }
        
        do {
            // Create an NSAttributedString from the HTML data
            let attributedString = try NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil)
            let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
            let font = UIFont(name: "Helvetica-Nueue", size: 16.0) ?? UIFont.systemFont(ofSize: 16.0)
            mutableAttributedString.addAttribute(.font, value: font, range: NSRange(location: 0, length: mutableAttributedString.length))
                    
            // Set the attributed string to the UILabel's attributedText
            paragraphLabel.attributedText = mutableAttributedString
        } catch {
            print("Error loading HTML into UILabel: \(error.localizedDescription)")
        }
    }
}
