//
//  NewsDetailViewController.swift
//  Hackathon sample app
//
//  Created by Arige Maheswari (Digital Business - Technology- Visakhapatnam) on 18/11/24.
//

import UIKit

class NewsDetailViewController: UIViewController {
    
    @IBOutlet weak var tableVIew: UITableView!
    var viewModel: NewsViewModel?
    var feedUrl: String?
    var detailItem: SectionItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NewsDetailTopAdCell.registerNib(tableVIew)
        NewsDetailHeaderInfoCell.registerNib(tableVIew)
        NewsDetailImageCaptionCell.registerNib(tableVIew)
        NewsDetailParagraphCell.registerNib(tableVIew)
        NewsDetailRelatedProductAdCell.registerNib(tableVIew)
        self.view.showActivityIndicator()
        
        viewModel?.fetchDetailNewsItem(urlString: feedUrl, completion: { [weak self] result in
            
            DispatchQueue.main.async {
                self?.view.hideActivityIndicator()
            }
            switch result {
            case .success(let data):
                self?.detailItem = data.content.sectionItems
                DispatchQueue.main.async {
                    self?.tableVIew.reloadData()
                }
                
            case .failure(let failure):
                debugPrint("failed to fetch the detail page contents", failure)
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNavBarAppearance()
    }
}

extension NewsDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.detailItem == nil ? 0 : 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell: NewsDetailTopAdCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
//            cell.configure(ad: <#T##String?#>) //need to pass adid here
            return cell
        case 1:
            let cell: NewsDetailHeaderInfoCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(headLine: self.detailItem?.headLine, postTime: self.detailItem?.publishedDate)
            return cell
        case 2:
            let cell: NewsDetailImageCaptionCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            var img = self.detailItem?.thumbImage ?? ""
            if img.isEmpty {
                img = self.detailItem?.mediumRes ?? ""
            }
            if img.isEmpty {
                img = self.detailItem?.wallpaperLarge ?? ""
            }

            cell.configure(imgStr: img, caption: self.detailItem?.caption)
            return cell
        case 3:
            let cell: NewsDetailParagraphCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(para: self.detailItem?.storyText)
//            cell.configure(para: "The Supreme Court directed the Delhi police to create a special cell for enforcing the ban on crackers.")
            return cell
        case 4:
            let cell: NewsDetailRelatedProductAdCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure()
            return cell
        default: break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension NewsDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
