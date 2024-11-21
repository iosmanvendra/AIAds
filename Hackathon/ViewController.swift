//
//  ViewController.swift
//  Hackathon sample app
//
//  Created by Arige Maheswari (Digital Business - Technology- Visakhapatnam) on 18/11/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let viewModel = NewsViewModel()
    var newsItems: [NewsItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red,
                                  NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        let navLogoImageView = UIImageView()
        navLogoImageView.frame = CGRect(x: 0, y: 0, width: 157, height: 30)
        navLogoImageView.contentMode = .scaleAspectFit
        navLogoImageView.image = UIImage(named: "ht_nav_logo")
        let barButton = UIBarButtonItem.init(customView: navLogoImageView)
        self.navigationItem.setLeftBarButtonItems([barButton], animated: true)
        self.title = "Hackathon"
        
        self.view.showActivityIndicator()
        // Do any additional setup after loading the view.
        NewsListTableCell.registerNib(tableView)
        
        viewModel.fetchNewsList { [weak self] result in
            
            DispatchQueue.main.async {
                self?.view.hideActivityIndicator()
            }
            
            switch result {
            case .success(let newsData):
                debugPrint("number of news items received:", newsData.data.count)
                self?.newsItems = newsData.data
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                debugPrint("error received:", error.localizedDescription)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNavBarAppearance()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsListTableCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let data = self.newsItems[indexPath.row]
        cell.configure(item: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //open detail page
        
        let vc = NewsDetailViewController()
        vc.viewModel = viewModel
        vc.feedUrl = self.newsItems[indexPath.row].detailFeedURL
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
