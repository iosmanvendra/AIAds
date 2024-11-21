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
    var ads: [CustomAdModel]?
    weak var delegate: NewsDetailProductAdCellDelegate?
    var collectionheight: CGFloat = 15.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NewsDetailCollectionCell.registerNib(collectionVIew)
    }
    
    func configure(ads: [CustomAdModel]) {
        self.ads = ads
        if ads.count > 0 {
            let width = UIScreen.main.bounds.width - 50.0
            let height = width * 0.75
            self.collectionheight = height
            self.collectionViewHeightConstraint.constant = height
            self.collectionVIew.reloadData()
        } else {
            self.collectionViewHeightConstraint.constant = 0.0
        }
    }
}

extension NewsDetailCarouselTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(5, self.ads?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NewsDetailCollectionCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.setData(ad: self.ads?[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.adTapped(ad: self.ads?[indexPath.item])
    }
}

extension NewsDetailCarouselTableCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 50.0
        return CGSize(width: width, height: collectionheight)
    }
}
