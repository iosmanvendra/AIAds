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
    var dataSource: [NewsDetailDataModel]?
    
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
                self?.dataSource = data
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
        return self.dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = dataSource?[indexPath.row]
        switch item?.type {
        case .topAd:
            let cell: NewsDetailTopAdCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(adUrl: item?.data.0) //TODO: need to pass adid here
            return cell
        case .header:
            let cell: NewsDetailHeaderInfoCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(headLine: item?.data.0, postTime: item?.data.1)
            return cell
            
        case .imageWithCaption:
            let cell: NewsDetailImageCaptionCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(imgStr: item?.data.0 ?? "", caption: item?.data.1)
            return cell
            
        case .paragraph:
            let cell: NewsDetailParagraphCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(para: item?.data.0)
            return cell
            
        case .customAd:
            let cell: NewsDetailRelatedProductAdCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.delegate = self
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

extension NewsDetailViewController: NewsDetailProductAdCellDelegate {
    
    func didTapBuyButton() {
        //TODO: action to be defined here:
    }
}
