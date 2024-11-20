//
//  NewsDetailCarouselTableCell.swift
//  Hackathon sample app
//
//  Created by Arige Maheswari (Digital Business - Technology- Visakhapatnam) on 18/11/24.
//

import UIKit

class NewsDetailCarouselTableCell: UITableViewCell {
    
    @IBOutlet weak var collectionVIew: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NewsDetailCollectionCell.registerNib(collectionVIew)
    }
}

extension NewsDetailCarouselTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NewsDetailCollectionCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.setData(text: "\(indexPath.item)")
        return cell
    }
}

extension NewsDetailCarouselTableCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150.0, height: 150.0)
    }
}
