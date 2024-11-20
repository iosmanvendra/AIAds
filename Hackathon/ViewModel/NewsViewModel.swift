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
    
    func fetchDetailNewsItem(urlString: String?, completion: @escaping (Result<NewsDetailItemData, Error>) -> Void) {
        
        guard let url = URL(string: urlString ?? "") else {
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
                let data = try JSONDecoder().decode(NewsDetailItemData.self, from: data)
                completion(.success(data))
            } catch {
                completion(.failure(error)) // Handle decoding error
            }
        }
            
        task.resume()
    }
}
