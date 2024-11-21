//
//  NewsViewModel.swift
//  Hackathon sample app
//
//  Created by Arige Maheswari (Digital Business - Technology- Visakhapatnam) on 19/11/24.
//

import Foundation
import SwiftyJSON

class NewsViewModel {
    
    func fetchNewsList(completion: @escaping (Result<NewsItemData, Error>) -> Void) {
        let urlString = "https://api.npoint.io/6239285b50e22a36d1ce"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error)) // Handle network error
                return
            }
                
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Invalid response", code: -1, userInfo: nil)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let data = try JSONDecoder().decode(NewsItemData.self, from: data)
                completion(.success(data))
            } catch {
                completion(.failure(error)) // Handle decoding error
            }
        }
            
        task.resume()
    }
    
    func fetchDetailNewsItem(urlString: String?, completion: @escaping (Result<[NewsDetailDataModel], Error>) -> Void) {
        
        guard let url = URL(string: urlString ?? "") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(error)) // Handle network error
                return
            }
                
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Invalid response", code: -1, userInfo: nil)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let data = try JSONDecoder().decode(NewsDetailItemData.self, from: data)
                let dataSource = self?.createDetailPageDataSource(data: data.content.sectionItems) ?? []
                completion(.success(dataSource))
            } catch {
                completion(.failure(error)) // Handle decoding error
            }
        }
            
        task.resume()
    }
    
    func createDetailPageDataSource(data: SectionItem?) -> [NewsDetailDataModel] {
        var dataSource = [NewsDetailDataModel]()
        dataSource.append(NewsDetailDataModel(type: .topAd, data: ("https://fastly.picsum.photos/id/944/320/100.jpg?hmac=G98Z41jxvM8WEcarkLHiRuqaBEdBBSljO5ylEzkoI60", nil)))//https://via.placeholder.com/320x100?text=Testing%20Ad
        dataSource.append(NewsDetailDataModel(type: .header, data: (data?.headLine, data?.publishedDate)))
        
        var img = data?.thumbImage ?? ""
        if img.isEmpty {
            img = data?.mediumRes ?? ""
        }
        if img.isEmpty {
            img = data?.wallpaperLarge ?? ""
        }
        
        dataSource.append(NewsDetailDataModel(type: .imageWithCaption, data: (img, data?.caption)))
        //split the paragraph tag and then add the model to datasource
        if let text = data?.storyText, !text.isEmpty {
            
            let splitParagraphs = text.components(separatedBy: "</p>")
            if splitParagraphs.count > 0 {
                for paragraph in splitParagraphs {
                    if (paragraph.isEmpty == true || paragraph == "\n" || paragraph == "<br>")
                    {
                        continue
                    }
                    if paragraph.isEmpty == false {
                        dataSource.append(NewsDetailDataModel(type: .paragraph, data: (paragraph, nil)))
                    }
                }
            } else {
                dataSource.append(NewsDetailDataModel(type: .paragraph, data: (nil, nil)))
            }
        }
        dataSource.append(NewsDetailDataModel(type: .customAd, data: (nil, nil)))
        return dataSource
    }
}

enum NewsDetailCellType {
    case topAd
    case header
    case imageWithCaption
    case paragraph
    case customAd
}
struct NewsDetailDataModel {
    var type: NewsDetailCellType
    var data: (String?, String?)
    
    init(type: NewsDetailCellType, data: (String?, String?)) {
        self.type = type
        self.data = data
    }
}
