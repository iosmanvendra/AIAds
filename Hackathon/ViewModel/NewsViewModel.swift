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
    
    func parseAds() -> [CustomAdModel]? {
        let ads: [CustomAdModel]?
        let json = """
        [
        {
          "title": "Media Platforms - Workout Programs",
          "description": "A high-quality product for fashion enthusiasts.",
          "banner url": "https://example.com/ad-1",
          "category": [
            "Media Platforms",
            "Fashion"
          ],
          "sub_category": [
            "Snacks",
            "Streaming Services",
            "Jerseys"
          ],
          "sub_to_sub_category": [
            "Home Assistants"
          ]
        },
        {
          "title": "Media Platforms - Streaming Services",
          "description": "A high-quality product for sports equipment enthusiasts.",
          "banner url": "https://example.com/ad-2",
          "category": [
            "Home Appliances",
            "Travel & Hospitality",
            "Food & Beverages"
          ],
          "sub_category": [
            "Electric Vehicles",
            "Smart Devices",
            "Kitchen Gadgets"
          ],
          "sub_to_sub_category": [
            "Health Snacks"
          ]
        },
        {
          "title": "Travel & Hospitality - Kitchen Gadgets",
          "description": "A high-quality product for fitness & wellness enthusiasts.",
          "banner url": "https://example.com/ad-3",
          "category": [
            "Sports Equipment",
            "Fashion",
            "Home Appliances"
          ],
          "sub_category": [
            "Smart Devices"
          ],
          "sub_to_sub_category": [
            "Health Snacks",
            "Live Cricket"
          ]
        },
        {
          "title": "Sports Equipment - Smart Devices",
          "description": "A high-quality product for home appliances enthusiasts.",
          "banner url": "https://example.com/ad-4",
          "category": [
            "Fitness & Wellness"
          ],
          "sub_category": [
            "Streaming Services",
            "Match Tickets",
            "Snacks"
          ],
          "sub_to_sub_category": [
            "Professional Gear"
          ]
        },
        {
          "title": "Media Platforms - Match Tickets",
          "description": "A high-quality product for home appliances enthusiasts.",
          "banner url": "https://example.com/ad-5",
          "category": [
            "Automotive",
            "Fan Merchandise"
          ],
          "sub_category": [
            "Athleisure",
            "Cricket Gear",
            "Electric Vehicles"
          ],
          "sub_to_sub_category": [
            "Nutrition Plans",
            "Eco-friendly Cars",
            "Official Merchandise"
          ]
        },
        {
          "title": "Fashion - Athleisure",
          "description": "A high-quality product for travel & hospitality enthusiasts.",
          "banner url": "https://example.com/ad-6",
          "category": [
            "Sports Equipment"
          ],
          "sub_category": [
            "Kitchen Gadgets"
          ],
          "sub_to_sub_category": [
            "Workout Clothing",
            "Professional Gear",
            "Live Cricket"
          ]
        },
        {
          "title": "Home Appliances - Cricket Gear",
          "description": "A high-quality product for fan merchandise enthusiasts.",
          "banner url": "https://example.com/ad-7",
          "category": [
            "Fashion",
            "Automotive"
          ],
          "sub_category": [
            "Smart Devices",
            "Cricket Gear"
          ],
          "sub_to_sub_category": [
            "Live Cricket",
            "Cooking Essentials"
          ]
        },
        {
          "title": "Sports Equipment - Snacks",
          "description": "A high-quality product for food & beverages enthusiasts.",
          "banner url": "https://example.com/ad-8",
          "category": [
            "Food & Beverages"
          ],
          "sub_category": [
            "Athleisure",
            "Streaming Services",
            "Snacks"
          ],
          "sub_to_sub_category": [
            "Cooking Essentials",
            "Eco-friendly Cars",
            "Live Cricket"
          ]
        },
        {
          "title": "Media Platforms - Electric Vehicles",
          "description": "A high-quality product for food & beverages enthusiasts.",
          "banner url": "https://example.com/ad-9",
          "category": [
            "Technology",
            "Media Platforms"
          ],
          "sub_category": [
            "Workout Programs",
            "Smart Devices",
            "Electric Vehicles"
          ],
          "sub_to_sub_category": [
            "Live Cricket",
            "Cooking Essentials"
          ]
        },
        {
          "title": "Technology - Workout Programs",
          "description": "A high-quality product for home appliances enthusiasts.",
          "banner url": "https://example.com/ad-10",
          "category": [
            "Food & Beverages",
            "Travel & Hospitality"
          ],
          "sub_category": [
            "Jerseys",
            "Snacks"
          ],
          "sub_to_sub_category": [
            "Professional Gear"
          ]
        },
        {
          "title": "Fashion - Kitchen Gadgets",
          "description": "A high-quality product for sports equipment enthusiasts.",
          "banner url": "https://example.com/ad-11",
          "category": [
            "Fan Merchandise",
            "Food & Beverages"
          ],
          "sub_category": [
            "Kitchen Gadgets",
            "Electric Vehicles"
          ],
          "sub_to_sub_category": [
            "Workout Clothing",
            "Health Snacks"
          ]
        },
        {
          "title": "Fitness & Wellness - Cricket Gear",
          "description": "A high-quality product for fashion enthusiasts.",
          "banner url": "https://example.com/ad-12",
          "category": [
            "Fashion",
            "Fan Merchandise"
          ],
          "sub_category": [
            "Cricket Gear"
          ],
          "sub_to_sub_category": [
            "Workout Clothing"
          ]
        },
        {
          "title": "Automotive - Match Tickets",
          "description": "A high-quality product for fitness & wellness enthusiasts.",
          "banner url": "https://example.com/ad-13",
          "category": [
            "Automotive",
            "Technology"
          ],
          "sub_category": [
            "Jerseys",
            "Kitchen Gadgets",
            "Workout Programs"
          ],
          "sub_to_sub_category": [
            "Nutrition Plans",
            "Home Assistants",
            "Workout Clothing"
          ]
        },
        {
          "title": "Technology - Smart Devices",
          "description": "A high-quality product for fan merchandise enthusiasts.",
          "banner url": "https://example.com/ad-14",
          "category": [
            "Media Platforms",
            "Travel & Hospitality"
          ],
          "sub_category": [
            "Electric Vehicles",
            "Athleisure",
            "Workout Programs"
          ],
          "sub_to_sub_category": [
            "Cooking Essentials"
          ]
        },
        {
          "title": "Fitness & Wellness - Jerseys",
          "description": "A high-quality product for fashion enthusiasts.",
          "banner url": "https://example.com/ad-15",
          "category": [
            "Automotive"
          ],
          "sub_category": [
            "Cricket Gear",
            "Match Tickets"
          ],
          "sub_to_sub_category": [
            "Live Cricket",
            "Health Snacks"
          ]
        },
        {
          "title": "Food & Beverages - Streaming Services",
          "description": "A high-quality product for automotive enthusiasts.",
          "banner url": "https://example.com/ad-16",
          "category": [
            "Media Platforms",
            "Fitness & Wellness",
            "Fashion"
          ],
          "sub_category": [
            "Workout Programs",
            "Jerseys",
            "Snacks"
          ],
          "sub_to_sub_category": [
            "Workout Clothing",
            "Professional Gear",
            "Home Assistants"
          ]
        },
        {
          "title": "Home Appliances - Cricket Gear",
          "description": "A high-quality product for travel & hospitality enthusiasts.",
          "banner url": "https://example.com/ad-17",
          "category": [
            "Media Platforms"
          ],
          "sub_category": [
            "Match Tickets",
            "Smart Devices"
          ],
          "sub_to_sub_category": [
            "Workout Clothing",
            "Cooking Essentials"
          ]
        },
        {
          "title": "Media Platforms - Smart Devices",
          "description": "A high-quality product for automotive enthusiasts.",
          "banner url": "https://example.com/ad-18",
          "category": [
            "Food & Beverages",
            "Home Appliances",
            "Automotive"
          ],
          "sub_category": [
            "Cricket Gear",
            "Match Tickets",
            "Snacks"
          ],
          "sub_to_sub_category": [
            "Professional Gear",
            "Travel Deals"
          ]
        },
        {
          "title": "Fitness & Wellness - Cricket Gear",
          "description": "A high-quality product for travel & hospitality enthusiasts.",
          "banner url": "https://example.com/ad-19",
          "category": [
            "Fan Merchandise"
          ],
          "sub_category": [
            "Match Tickets"
          ],
          "sub_to_sub_category": [
            "Travel Deals",
            "Workout Clothing"
          ]
        },
        {
          "title": "Fitness & Wellness - Snacks",
          "description": "A high-quality product for media platforms enthusiasts.",
          "banner url": "https://example.com/ad-20",
          "category": [
            "Home Appliances",
            "Travel & Hospitality"
          ],
          "sub_category": [
            "Jerseys",
            "Cricket Gear",
            "Streaming Services"
          ],
          "sub_to_sub_category": [
            "Professional Gear",
            "Live Cricket"
          ]
        },
        {
          "title": "Media Platforms - Smart Devices",
          "description": "A high-quality product for media platforms enthusiasts.",
          "banner url": "https://example.com/ad-21",
          "category": [
            "Home Appliances"
          ],
          "sub_category": [
            "Kitchen Gadgets",
            "Athleisure",
            "Jerseys"
          ],
          "sub_to_sub_category": [
            "Eco-friendly Cars",
            "Cooking Essentials",
            "Professional Gear"
          ]
        },
        {
          "title": "Automotive - Snacks",
          "description": "A high-quality product for fitness & wellness enthusiasts.",
          "banner url": "https://example.com/ad-22",
          "category": [
            "Food & Beverages"
          ],
          "sub_category": [
            "Cricket Gear",
            "Match Tickets"
          ],
          "sub_to_sub_category": [
            "Nutrition Plans",
            "Official Merchandise",
            "Home Assistants"
          ]
        },
        {
          "title": "Media Platforms - Kitchen Gadgets",
          "description": "A high-quality product for food & beverages enthusiasts.",
          "banner url": "https://example.com/ad-23",
          "category": [
            "Fitness & Wellness"
          ],
          "sub_category": [
            "Workout Programs",
            "Match Tickets",
            "Kitchen Gadgets"
          ],
          "sub_to_sub_category": [
            "Health Snacks",
            "Eco-friendly Cars"
          ]
        },
        {
          "title": "Media Platforms - Kitchen Gadgets",
          "description": "A high-quality product for fan merchandise enthusiasts.",
          "banner url": "https://example.com/ad-24",
          "category": [
            "Technology",
            "Fashion"
          ],
          "sub_category": [
            "Workout Programs",
            "Smart Devices",
            "Snacks"
          ],
          "sub_to_sub_category": [
            "Workout Clothing"
          ]
        },
        {
          "title": "Home Appliances - Snacks",
          "description": "A high-quality product for fitness & wellness enthusiasts.",
          "banner url": "https://example.com/ad-25",
          "category": [
            "Fashion",
            "Technology",
            "Media Platforms"
          ],
          "sub_category": [
            "Jerseys",
            "Snacks"
          ],
          "sub_to_sub_category": [
            "Live Cricket"
          ]
        },
        {
          "title": "Food & Beverages - Match Tickets",
          "description": "A high-quality product for fan merchandise enthusiasts.",
          "banner url": "https://example.com/ad-26",
          "category": [
            "Travel & Hospitality",
            "Home Appliances",
            "Media Platforms"
          ],
          "sub_category": [
            "Match Tickets",
            "Jerseys",
            "Athleisure"
          ],
          "sub_to_sub_category": [
            "Nutrition Plans",
            "Official Merchandise"
          ]
        },
        {
          "title": "Food & Beverages - Kitchen Gadgets",
          "description": "A high-quality product for food & beverages enthusiasts.",
          "banner url": "https://example.com/ad-27",
          "category": [
            "Travel & Hospitality",
            "Sports Equipment",
            "Fan Merchandise"
          ],
          "sub_category": [
            "Kitchen Gadgets",
            "Streaming Services",
            "Workout Programs"
          ],
          "sub_to_sub_category": [
            "Official Merchandise",
            "Live Cricket",
            "Eco-friendly Cars"
          ]
        },
        {
          "title": "Food & Beverages - Match Tickets",
          "description": "A high-quality product for automotive enthusiasts.",
          "banner url": "https://example.com/ad-28",
          "category": [
            "Travel & Hospitality",
            "Fitness & Wellness"
          ],
          "sub_category": [
            "Snacks",
            "Workout Programs"
          ],
          "sub_to_sub_category": [
            "Live Cricket"
          ]
        },
        {
          "title": "Technology - Match Tickets",
          "description": "A high-quality product for home appliances enthusiasts.",
          "banner url": "https://example.com/ad-29",
          "category": [
            "Fan Merchandise",
            "Technology"
          ],
          "sub_category": [
            "Jerseys",
            "Athleisure"
          ],
          "sub_to_sub_category": [
            "Cooking Essentials",
            "Health Snacks",
            "Professional Gear"
          ]
        },
        {
          "title": "Sports Equipment - Jerseys",
          "description": "A high-quality product for technology enthusiasts.",
          "banner url": "https://example.com/ad-30",
          "category": [
            "Fitness & Wellness"
          ],
          "sub_category": [
            "Match Tickets",
            "Electric Vehicles",
            "Jerseys"
          ],
          "sub_to_sub_category": [
            "Home Assistants",
            "Live Cricket"
          ]
        },
        {
          "title": "Travel & Hospitality - Kitchen Gadgets",
          "description": "A high-quality product for fan merchandise enthusiasts.",
          "banner url": "https://example.com/ad-31",
          "category": [
            "Travel & Hospitality",
            "Technology",
            "Fan Merchandise"
          ],
          "sub_category": [
            "Electric Vehicles"
          ],
          "sub_to_sub_category": [
            "Nutrition Plans"
          ]
        },
        {
          "title": "Travel & Hospitality - Streaming Services",
          "description": "A high-quality product for sports equipment enthusiasts.",
          "banner url": "https://example.com/ad-32",
          "category": [
            "Media Platforms",
            "Technology"
          ],
          "sub_category": [
            "Match Tickets",
            "Smart Devices"
          ],
          "sub_to_sub_category": [
            "Home Assistants",
            "Cooking Essentials"
          ]
        },
        {
          "title": "Technology - Jerseys",
          "description": "A high-quality product for fitness & wellness enthusiasts.",
          "banner url": "https://example.com/ad-33",
          "category": [
            "Travel & Hospitality"
          ],
          "sub_category": [
            "Workout Programs",
            "Electric Vehicles",
            "Kitchen Gadgets"
          ],
          "sub_to_sub_category": [
            "Nutrition Plans"
          ]
        },
        {
          "title": "Home Appliances - Athleisure",
          "description": "A high-quality product for fashion enthusiasts.",
          "banner url": "https://example.com/ad-34",
          "category": [
            "Fitness & Wellness",
            "Automotive",
            "Fan Merchandise"
          ],
          "sub_category": [
            "Snacks",
            "Workout Programs"
          ],
          "sub_to_sub_category": [
            "Travel Deals",
            "Home Assistants"
          ]
        },
        {
          "title": "Media Platforms - Snacks",
          "description": "A high-quality product for travel & hospitality enthusiasts.",
          "banner url": "https://example.com/ad-35",
          "category": [
            "Fan Merchandise"
          ],
          "sub_category": [
            "Snacks",
            "Jerseys",
            "Streaming Services"
          ],
          "sub_to_sub_category": [
            "Home Assistants",
            "Professional Gear",
            "Travel Deals"
          ]
        },
        {
          "title": "Fitness & Wellness - Streaming Services",
          "description": "A high-quality product for media platforms enthusiasts.",
          "banner url": "https://example.com/ad-36",
          "category": [
            "Food & Beverages",
            "Home Appliances",
            "Sports Equipment"
          ],
          "sub_category": [
            "Snacks",
            "Smart Devices"
          ],
          "sub_to_sub_category": [
            "Cooking Essentials",
            "Official Merchandise"
          ]
        },
        {
          "title": "Technology - Kitchen Gadgets",
          "description": "A high-quality product for sports equipment enthusiasts.",
          "banner url": "https://example.com/ad-37",
          "category": [
            "Automotive"
          ],
          "sub_category": [
            "Jerseys",
            "Cricket Gear",
            "Kitchen Gadgets"
          ],
          "sub_to_sub_category": [
            "Eco-friendly Cars",
            "Nutrition Plans"
          ]
        },
        {
          "title": "Sports Equipment - Workout Programs",
          "description": "A high-quality product for technology enthusiasts.",
          "banner url": "https://example.com/ad-38",
          "category": [
            "Home Appliances"
          ],
          "sub_category": [
            "Jerseys"
          ],
          "sub_to_sub_category": [
            "Health Snacks",
            "Eco-friendly Cars"
          ]
        },
        {
          "title": "Media Platforms - Jerseys",
          "description": "A high-quality product for automotive enthusiasts.",
          "banner url": "https://example.com/ad-39",
          "category": [
            "Technology",
            "Fan Merchandise"
          ],
          "sub_category": [
            "Snacks",
            "Cricket Gear"
          ],
          "sub_to_sub_category": [
            "Eco-friendly Cars"
          ]
        },
        {
          "title": "Automotive - Workout Programs",
          "description": "A high-quality product for automotive enthusiasts.",
          "banner url": "https://example.com/ad-40",
          "category": [
            "Home Appliances"
          ],
          "sub_category": [
            "Electric Vehicles"
          ],
          "sub_to_sub_category": [
            "Official Merchandise"
          ]
        },
        {
          "title": "Sports Equipment - Streaming Services",
          "description": "A high-quality product for media platforms enthusiasts.",
          "banner url": "https://example.com/ad-41",
          "category": [
            "Fitness & Wellness",
            "Technology"
          ],
          "sub_category": [
            "Snacks",
            "Athleisure",
            "Match Tickets"
          ],
          "sub_to_sub_category": [
            "Cooking Essentials"
          ]
        },
        {
          "title": "Travel & Hospitality - Snacks",
          "description": "A high-quality product for technology enthusiasts.",
          "banner url": "https://example.com/ad-42",
          "category": [
            "Travel & Hospitality"
          ],
          "sub_category": [
            "Workout Programs",
            "Snacks",
            "Electric Vehicles"
          ],
          "sub_to_sub_category": [
            "Live Cricket",
            "Home Assistants"
          ]
        },
        {
          "title": "Home Appliances - Jerseys",
          "description": "A high-quality product for fitness & wellness enthusiasts.",
          "banner url": "https://example.com/ad-43",
          "category": [
            "Food & Beverages",
            "Fashion",
            "Travel & Hospitality"
          ],
          "sub_category": [
            "Cricket Gear",
            "Kitchen Gadgets",
            "Electric Vehicles"
          ],
          "sub_to_sub_category": [
            "Live Cricket",
            "Home Assistants"
          ]
        },
        {
          "title": "Technology - Electric Vehicles",
          "description": "A high-quality product for fashion enthusiasts.",
          "banner url": "https://example.com/ad-44",
          "category": [
            "Sports Equipment",
            "Technology",
            "Home Appliances"
          ],
          "sub_category": [
            "Smart Devices"
          ],
          "sub_to_sub_category": [
            "Professional Gear"
          ]
        },
        {
          "title": "Food & Beverages - Snacks",
          "description": "A high-quality product for home appliances enthusiasts.",
          "banner url": "https://example.com/ad-45",
          "category": [
            "Fan Merchandise",
            "Fitness & Wellness"
          ],
          "sub_category": [
            "Match Tickets",
            "Smart Devices"
          ],
          "sub_to_sub_category": [
            "Health Snacks"
          ]
        },
        {
          "title": "Travel & Hospitality - Match Tickets",
          "description": "A high-quality product for technology enthusiasts.",
          "banner url": "https://example.com/ad-46",
          "category": [
            "Technology"
          ],
          "sub_category": [
            "Workout Programs",
            "Electric Vehicles",
            "Athleisure"
          ],
          "sub_to_sub_category": [
            "Nutrition Plans"
          ]
        },
        {
          "title": "Home Appliances - Streaming Services",
          "description": "A high-quality product for media platforms enthusiasts.",
          "banner url": "https://example.com/ad-47",
          "category": [
            "Home Appliances"
          ],
          "sub_category": [
            "Electric Vehicles"
          ],
          "sub_to_sub_category": [
            "Home Assistants"
          ]
        },
        {
          "title": "Technology - Jerseys",
          "description": "A high-quality product for automotive enthusiasts.",
          "banner url": "https://example.com/ad-48",
          "category": [
            "Fashion"
          ],
          "sub_category": [
            "Athleisure"
          ],
          "sub_to_sub_category": [
            "Eco-friendly Cars",
            "Travel Deals",
            "Professional Gear"
          ]
        },
        {
          "title": "Food & Beverages - Streaming Services",
          "description": "A high-quality product for travel & hospitality enthusiasts.",
          "banner url": "https://example.com/ad-49",
          "category": [
            "Technology"
          ],
          "sub_category": [
            "Electric Vehicles",
            "Smart Devices",
            "Streaming Services"
          ],
          "sub_to_sub_category": [
            "Workout Clothing"
          ]
        },
        {
          "title": "Home Appliances - Electric Vehicles",
          "description": "A high-quality product for sports equipment enthusiasts.",
          "banner url": "https://example.com/ad-50",
          "category": [
            "Travel & Hospitality",
            "Fashion",
            "Automotive"
          ],
          "sub_category": [
            "Workout Programs",
            "Smart Devices"
          ],
          "sub_to_sub_category": [
            "Professional Gear",
            "Workout Clothing"
          ]
        },
        {
          "title": "Fan Merchandise - Cricket Gear",
          "description": "A high-quality product for fitness & wellness enthusiasts.",
          "banner url": "https://example.com/ad-51",
          "category": [
            "Travel & Hospitality",
            "Home Appliances"
          ],
          "sub_category": [
            "Workout Programs"
          ],
          "sub_to_sub_category": [
            "Health Snacks"
          ]
        },
        {
          "title": "Food & Beverages - Cricket Gear",
          "description": "A high-quality product for fashion enthusiasts.",
          "banner url": "https://example.com/ad-52",
          "category": [
            "Home Appliances"
          ],
          "sub_category": [
            "Kitchen Gadgets",
            "Smart Devices"
          ],
          "sub_to_sub_category": [
            "Professional Gear"
          ]
        },
        {
          "title": "Sports Equipment - Streaming Services",
          "description": "A high-quality product for travel & hospitality enthusiasts.",
          "banner url": "https://example.com/ad-53",
          "category": [
            "Fan Merchandise"
          ],
          "sub_category": [
            "Streaming Services",
            "Jerseys",
            "Kitchen Gadgets"
          ],
          "sub_to_sub_category": [
            "Professional Gear",
            "Travel Deals",
            "Workout Clothing"
          ]
        },
        {
          "title": "Food & Beverages - Cricket Gear",
          "description": "A high-quality product for home appliances enthusiasts.",
          "banner url": "https://example.com/ad-54",
          "category": [
            "Home Appliances",
            "Fitness & Wellness"
          ],
          "sub_category": [
            "Cricket Gear"
          ],
          "sub_to_sub_category": [
            "Official Merchandise",
            "Live Cricket",
            "Workout Clothing"
          ]
        },
        {
          "title": "Media Platforms - Kitchen Gadgets",
          "description": "A high-quality product for automotive enthusiasts.",
          "banner url": "https://example.com/ad-55",
          "category": [
            "Fitness & Wellness"
          ],
          "sub_category": [
            "Cricket Gear",
            "Streaming Services",
            "Smart Devices"
          ],
          "sub_to_sub_category": [
            "Health Snacks",
            "Home Assistants",
            "Professional Gear"
          ]
        },
        {
          "title": "Fan Merchandise - Workout Programs",
          "description": "A high-quality product for media platforms enthusiasts.",
          "banner url": "https://example.com/ad-56",
          "category": [
            "Media Platforms"
          ],
          "sub_category": [
            "Match Tickets",
            "Jerseys",
            "Kitchen Gadgets"
          ],
          "sub_to_sub_category": [
            "Travel Deals",
            "Eco-friendly Cars"
          ]
        },
        {
          "title": "Fitness & Wellness - Kitchen Gadgets",
          "description": "A high-quality product for media platforms enthusiasts.",
          "banner url": "https://example.com/ad-57",
          "category": [
            "Travel & Hospitality",
            "Fitness & Wellness"
          ],
          "sub_category": [
            "Electric Vehicles",
            "Smart Devices",
            "Workout Programs"
          ],
          "sub_to_sub_category": [
            "Cooking Essentials",
            "Nutrition Plans"
          ]
        },
        {
          "title": "Fan Merchandise - Snacks",
          "description": "A high-quality product for fashion enthusiasts.",
          "banner url": "https://example.com/ad-58",
          "category": [
            "Food & Beverages"
          ],
          "sub_category": [
            "Smart Devices",
            "Jerseys"
          ],
          "sub_to_sub_category": [
            "Eco-friendly Cars"
          ]
        },
        {
          "title": "Fashion - Smart Devices",
          "description": "A high-quality product for travel & hospitality enthusiasts.",
          "banner url": "https://example.com/ad-59",
          "category": [
            "Food & Beverages",
            "Fitness & Wellness"
          ],
          "sub_category": [
            "Cricket Gear",
            "Match Tickets"
          ],
          "sub_to_sub_category": [
            "Workout Clothing",
            "Cooking Essentials",
            "Professional Gear"
          ]
        },
        {
          "title": "Fitness & Wellness - Workout Programs",
          "description": "A high-quality product for travel & hospitality enthusiasts.",
          "banner url": "https://example.com/ad-60",
          "category": [
            "Media Platforms",
            "Fan Merchandise",
            "Sports Equipment"
          ],
          "sub_category": [
            "Snacks"
          ],
          "sub_to_sub_category": [
            "Cooking Essentials"
          ]
        },
        {
          "title": "Automotive - Jerseys",
          "description": "A high-quality product for media platforms enthusiasts.",
          "banner url": "https://example.com/ad-61",
          "category": [
            "Travel & Hospitality",
            "Automotive"
          ],
          "sub_category": [
            "Cricket Gear",
            "Kitchen Gadgets",
            "Streaming Services"
          ],
          "sub_to_sub_category": [
            "Professional Gear",
            "Health Snacks"
          ]
        },
        {
          "title": "Automotive - Match Tickets",
          "description": "A high-quality product for travel & hospitality enthusiasts.",
          "banner url": "https://example.com/ad-62",
          "category": [
            "Automotive"
          ],
          "sub_category": [
            "Smart Devices",
            "Match Tickets",
            "Streaming Services"
          ],
          "sub_to_sub_category": [
            "Live Cricket",
            "Professional Gear",
            "Travel Deals"
          ]
        },
        {
          "title": "Fashion - Streaming Services",
          "description": "A high-quality product for travel & hospitality enthusiasts.",
          "banner url": "https://example.com/ad-63",
          "category": [
            "Media Platforms"
          ],
          "sub_category": [
            "Electric Vehicles",
            "Athleisure",
            "Kitchen Gadgets"
          ],
          "sub_to_sub_category": [
            "Eco-friendly Cars",
            "Cooking Essentials",
            "Live Cricket"
          ]
        },
        {
          "title": "Media Platforms - Electric Vehicles",
          "description": "A high-quality product for automotive enthusiasts.",
          "banner url": "https://example.com/ad-64",
          "category": [
            "Media Platforms",
            "Food & Beverages",
            "Automotive"
          ],
          "sub_category": [
            "Kitchen Gadgets",
            "Workout Programs"
          ],
          "sub_to_sub_category": [
            "Cooking Essentials",
            "Home Assistants",
            "Nutrition Plans"
          ]
        },
        {
          "title": "Fitness & Wellness - Streaming Services",
          "description": "A high-quality product for media platforms enthusiasts.",
          "banner url": "https://example.com/ad-65",
          "category": [
            "Technology"
          ],
          "sub_category": [
            "Workout Programs"
          ],
          "sub_to_sub_category": [
            "Home Assistants",
            "Cooking Essentials"
          ]
        },
        {
          "title": "Travel & Hospitality - Jerseys",
          "description": "A high-quality product for automotive enthusiasts.",
          "banner url": "https://example.com/ad-66",
          "category": [
            "Fitness & Wellness",
            "Technology",
            "Fashion"
          ],
          "sub_category": [
            "Smart Devices"
          ],
          "sub_to_sub_category": [
            "Eco-friendly Cars",
            "Workout Clothing"
          ]
        },
        {
          "title": "Fan Merchandise - Jerseys",
          "description": "A high-quality product for technology enthusiasts.",
          "banner url": "https://example.com/ad-67",
          "category": [
            "Fan Merchandise"
          ],
          "sub_category": [
            "Jerseys",
            "Streaming Services"
          ],
          "sub_to_sub_category": [
            "Workout Clothing",
            "Nutrition Plans",
            "Health Snacks"
          ]
        },
        {
          "title": "Sports Equipment - Smart Devices",
          "description": "A high-quality product for food & beverages enthusiasts.",
          "banner url": "https://example.com/ad-68",
          "category": [
            "Technology",
            "Travel & Hospitality"
          ],
          "sub_category": [
            "Kitchen Gadgets"
          ],
          "sub_to_sub_category": [
            "Live Cricket",
            "Home Assistants"
          ]
        },
        {
          "title": "Fan Merchandise - Match Tickets",
          "description": "A high-quality product for fitness & wellness enthusiasts.",
          "banner url": "https://example.com/ad-69",
          "category": [
            "Fan Merchandise",
            "Food & Beverages"
          ],
          "sub_category": [
            "Match Tickets",
            "Streaming Services",
            "Electric Vehicles"
          ],
          "sub_to_sub_category": [
            "Workout Clothing",
            "Official Merchandise"
          ]
        },
        {
          "title": "Media Platforms - Snacks",
          "description": "A high-quality product for fitness & wellness enthusiasts.",
          "banner url": "https://example.com/ad-70",
          "category": [
            "Sports Equipment",
            "Travel & Hospitality",
            "Food & Beverages"
          ],
          "sub_category": [
            "Jerseys",
            "Electric Vehicles"
          ],
          "sub_to_sub_category": [
            "Travel Deals",
            "Home Assistants"
          ]
        },
        {
          "title": "Technology - Workout Programs",
          "description": "A high-quality product for food & beverages enthusiasts.",
          "banner url": "https://example.com/ad-71",
          "category": [
            "Travel & Hospitality",
            "Fashion",
            "Sports Equipment"
          ],
          "sub_category": [
            "Cricket Gear"
          ],
          "sub_to_sub_category": [
            "Nutrition Plans",
            "Home Assistants",
            "Live Cricket"
          ]
        },
        {
          "title": "Fashion - Snacks",
          "description": "A high-quality product for fashion enthusiasts.",
          "banner url": "https://example.com/ad-72",
          "category": [
            "Fitness & Wellness"
          ],
          "sub_category": [
            "Workout Programs",
            "Snacks",
            "Match Tickets"
          ],
          "sub_to_sub_category": [
            "Eco-friendly Cars",
            "Nutrition Plans",
            "Travel Deals"
          ]
        },
        {
          "title": "Technology - Jerseys",
          "description": "A high-quality product for fan merchandise enthusiasts.",
          "banner url": "https://example.com/ad-73",
          "category": [
            "Media Platforms",
            "Automotive",
            "Food & Beverages"
          ],
          "sub_category": [
            "Smart Devices"
          ],
          "sub_to_sub_category": [
            "Live Cricket",
            "Health Snacks",
            "Eco-friendly Cars"
          ]
        },
        {
          "title": "Food & Beverages - Match Tickets",
          "description": "A high-quality product for fashion enthusiasts.",
          "banner url": "https://example.com/ad-74",
          "category": [
            "Fitness & Wellness",
            "Technology"
          ],
          "sub_category": [
            "Workout Programs",
            "Cricket Gear",
            "Smart Devices"
          ],
          "sub_to_sub_category": [
            "Home Assistants"
          ]
        },
        {
          "title": "Home Appliances - Streaming Services",
          "description": "A high-quality product for technology enthusiasts.",
          "banner url": "https://example.com/ad-75",
          "category": [
            "Travel & Hospitality",
            "Fashion",
            "Fitness & Wellness"
          ],
          "sub_category": [
            "Cricket Gear"
          ],
          "sub_to_sub_category": [
            "Official Merchandise"
          ]
        },
        {
          "title": "Media Platforms - Workout Programs",
          "description": "A high-quality product for fitness & wellness enthusiasts.",
          "banner url": "https://example.com/ad-76",
          "category": [
            "Technology",
            "Sports Equipment"
          ],
          "sub_category": [
            "Electric Vehicles",
            "Snacks",
            "Athleisure"
          ],
          "sub_to_sub_category": [
            "Health Snacks"
          ]
        },
        {
          "title": "Sports Equipment - Jerseys",
          "description": "A high-quality product for automotive enthusiasts.",
          "banner url": "https://example.com/ad-77",
          "category": [
            "Fitness & Wellness",
            "Food & Beverages",
            "Technology"
          ],
          "sub_category": [
            "Smart Devices",
            "Electric Vehicles"
          ],
          "sub_to_sub_category": [
            "Workout Clothing",
            "Nutrition Plans",
            "Professional Gear"
          ]
        },
        {
          "title": "Fashion - Cricket Gear",
          "description": "A high-quality product for fashion enthusiasts.",
          "banner url": "https://example.com/ad-78",
          "category": [
            "Food & Beverages",
            "Sports Equipment"
          ],
          "sub_category": [
            "Streaming Services",
            "Kitchen Gadgets",
            "Cricket Gear"
          ],
          "sub_to_sub_category": [
            "Live Cricket",
            "Cooking Essentials"
          ]
        },
        {
          "title": "Food & Beverages - Jerseys",
          "description": "A high-quality product for fitness & wellness enthusiasts.",
          "banner url": "https://example.com/ad-79",
          "category": [
            "Fashion",
            "Home Appliances"
          ],
          "sub_category": [
            "Snacks",
            "Athleisure",
            "Workout Programs"
          ],
          "sub_to_sub_category": [
            "Travel Deals",
            "Health Snacks",
            "Live Cricket"
          ]
        },
        {
          "title": "Travel & Hospitality - Electric Vehicles",
          "description": "A high-quality product for travel & hospitality enthusiasts.",
          "banner url": "https://example.com/ad-80",
          "category": [
            "Fashion"
          ],
          "sub_category": [
            "Smart Devices",
            "Match Tickets"
          ],
          "sub_to_sub_category": [
            "Cooking Essentials"
          ]
        },
        {
          "title": "Fitness & Wellness - Streaming Services",
          "description": "A high-quality product for automotive enthusiasts.",
          "banner url": "https://example.com/ad-81",
          "category": [
            "Fitness & Wellness",
            "Fashion"
          ],
          "sub_category": [
            "Smart Devices"
          ],
          "sub_to_sub_category": [
            "Health Snacks",
            "Nutrition Plans",
            "Official Merchandise"
          ]
        },
        {
          "title": "Automotive - Streaming Services",
          "description": "A high-quality product for technology enthusiasts.",
          "banner url": "https://example.com/ad-82",
          "category": [
            "Fitness & Wellness",
            "Automotive",
            "Home Appliances"
          ],
          "sub_category": [
            "Cricket Gear"
          ],
          "sub_to_sub_category": [
            "Travel Deals"
          ]
        },
        {
          "title": "Travel & Hospitality - Match Tickets",
          "description": "A high-quality product for sports equipment enthusiasts.",
          "banner url": "https://example.com/ad-83",
          "category": [
            "Automotive",
            "Home Appliances",
            "Fitness & Wellness"
          ],
          "sub_category": [
            "Cricket Gear",
            "Smart Devices"
          ],
          "sub_to_sub_category": [
            "Workout Clothing",
            "Cooking Essentials",
            "Professional Gear"
          ]
        },
        {
          "title": "Automotive - Athleisure",
          "description": "A high-quality product for food & beverages enthusiasts.",
          "banner url": "https://example.com/ad-84",
          "category": [
            "Fashion",
            "Home Appliances"
          ],
          "sub_category": [
            "Match Tickets"
          ],
          "sub_to_sub_category": [
            "Eco-friendly Cars",
            "Home Assistants",
            "Nutrition Plans"
          ]
        },
        {
          "title": "Food & Beverages - Snacks",
          "description": "A high-quality product for home appliances enthusiasts.",
          "banner url": "https://example.com/ad-85",
          "category": [
            "Technology"
          ],
          "sub_category": [
            "Smart Devices",
            "Jerseys"
          ],
          "sub_to_sub_category": [
            "Health Snacks",
            "Live Cricket"
          ]
        },
        {
          "title": "Sports Equipment - Streaming Services",
          "description": "A high-quality product for fashion enthusiasts.",
          "banner url": "https://example.com/ad-86",
          "category": [
            "Travel & Hospitality",
            "Fan Merchandise"
          ],
          "sub_category": [
            "Streaming Services",
            "Workout Programs"
          ],
          "sub_to_sub_category": [
            "Home Assistants",
            "Travel Deals",
            "Professional Gear"
          ]
        },
        {
          "title": "Fashion - Streaming Services",
          "description": "A high-quality product for food & beverages enthusiasts.",
          "banner url": "https://example.com/ad-87",
          "category": [
            "Media Platforms",
            "Fashion",
            "Travel & Hospitality"
          ],
          "sub_category": [
            "Match Tickets",
            "Athleisure",
            "Kitchen Gadgets"
          ],
          "sub_to_sub_category": [
            "Workout Clothing"
          ]
        },
        {
          "title": "Home Appliances - Workout Programs",
          "description": "A high-quality product for fashion enthusiasts.",
          "banner url": "https://example.com/ad-88",
          "category": [
            "Fan Merchandise",
            "Home Appliances",
            "Fashion"
          ],
          "sub_category": [
            "Snacks",
            "Jerseys",
            "Cricket Gear"
          ],
          "sub_to_sub_category": [
            "Health Snacks"
          ]
        },
        {
          "title": "Sports Equipment - Kitchen Gadgets",
          "description": "A high-quality product for fashion enthusiasts.",
          "banner url": "https://example.com/ad-89",
          "category": [
            "Sports Equipment"
          ],
          "sub_category": [
            "Electric Vehicles"
          ],
          "sub_to_sub_category": [
            "Eco-friendly Cars",
            "Professional Gear",
            "Cooking Essentials"
          ]
        },
        {
          "title": "Sports Equipment - Smart Devices",
          "description": "A high-quality product for automotive enthusiasts.",
          "banner url": "https://example.com/ad-90",
          "category": [
            "Media Platforms",
            "Sports Equipment"
          ],
          "sub_category": [
            "Smart Devices",
            "Kitchen Gadgets"
          ],
          "sub_to_sub_category": [
            "Workout Clothing",
            "Official Merchandise"
          ]
        },
        {
          "title": "Media Platforms - Jerseys",
          "description": "A high-quality product for travel & hospitality enthusiasts.",
          "banner url": "https://example.com/ad-91",
          "category": [
            "Technology",
            "Travel & Hospitality"
          ],
          "sub_category": [
            "Streaming Services"
          ],
          "sub_to_sub_category": [
            "Workout Clothing"
          ]
        },
        {
          "title": "Media Platforms - Cricket Gear",
          "description": "A high-quality product for sports equipment enthusiasts.",
          "banner url": "https://example.com/ad-92",
          "category": [
            "Fan Merchandise",
            "Sports Equipment"
          ],
          "sub_category": [
            "Workout Programs",
            "Smart Devices",
            "Athleisure"
          ],
          "sub_to_sub_category": [
            "Health Snacks"
          ]
        },
        {
          "title": "Technology - Workout Programs",
          "description": "A high-quality product for fan merchandise enthusiasts.",
          "banner url": "https://example.com/ad-93",
          "category": [
            "Fan Merchandise",
            "Travel & Hospitality",
            "Food & Beverages"
          ],
          "sub_category": [
            "Workout Programs",
            "Streaming Services"
          ],
          "sub_to_sub_category": [
            "Eco-friendly Cars",
            "Health Snacks",
            "Cooking Essentials"
          ]
        },
        {
          "title": "Technology - Athleisure",
          "description": "A high-quality product for media platforms enthusiasts.",
          "banner url": "https://example.com/ad-94",
          "category": [
            "Technology"
          ],
          "sub_category": [
            "Workout Programs",
            "Athleisure",
            "Cricket Gear"
          ],
          "sub_to_sub_category": [
            "Eco-friendly Cars",
            "Nutrition Plans",
            "Cooking Essentials"
          ]
        },
        {
          "title": "Fashion - Match Tickets",
          "description": "A high-quality product for sports equipment enthusiasts.",
          "banner url": "https://example.com/ad-95",
          "category": [
            "Automotive",
            "Travel & Hospitality"
          ],
          "sub_category": [
            "Electric Vehicles",
            "Snacks"
          ],
          "sub_to_sub_category": [
            "Live Cricket"
          ]
        },
        {
          "title": "Fashion - Smart Devices",
          "description": "A high-quality product for technology enthusiasts.",
          "banner url": "https://example.com/ad-96",
          "category": [
            "Sports Equipment",
            "Technology"
          ],
          "sub_category": [
            "Athleisure",
            "Jerseys"
          ],
          "sub_to_sub_category": [
            "Workout Clothing"
          ]
        },
        {
          "title": "Home Appliances - Workout Programs",
          "description": "A high-quality product for fan merchandise enthusiasts.",
          "banner url": "https://example.com/ad-97",
          "category": [
            "Food & Beverages"
          ],
          "sub_category": [
            "Kitchen Gadgets"
          ],
          "sub_to_sub_category": [
            "Nutrition Plans"
          ]
        },
        {
          "title": "Home Appliances - Workout Programs",
          "description": "A high-quality product for automotive enthusiasts.",
          "banner url": "https://example.com/ad-98",
          "category": [
            "Travel & Hospitality",
            "Media Platforms",
            "Sports Equipment"
          ],
          "sub_category": [
            "Smart Devices",
            "Snacks",
            "Kitchen Gadgets"
          ],
          "sub_to_sub_category": [
            "Official Merchandise"
          ]
        },
        {
          "title": "Travel & Hospitality - Cricket Gear",
          "description": "A high-quality product for fan merchandise enthusiasts.",
          "banner url": "https://example.com/ad-99",
          "category": [
            "Fashion",
            "Fan Merchandise"
          ],
          "sub_category": [
            "Electric Vehicles",
            "Match Tickets",
            "Workout Programs"
          ],
          "sub_to_sub_category": [
            "Cooking Essentials",
            "Travel Deals"
          ]
        },
        {
          "title": "Technology - Smart Devices",
          "description": "A high-quality product for media platforms enthusiasts.",
          "banner url": "https://example.com/ad-100",
          "category": [
            "Home Appliances",
            "Fitness & Wellness"
          ],
          "sub_category": [
            "Cricket Gear",
            "Athleisure"
          ],
          "sub_to_sub_category": [
            "Professional Gear",
            "Eco-friendly Cars",
            "Workout Clothing"
          ]
        }
        ]
        """
        if let jsonData = json.data(using: .utf8) {
            do {
                let data = try JSONDecoder().decode([CustomAdModel].self, from: jsonData)
                return data
            } catch {
                return nil
            }
        }
        return nil
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
            let ads = parseAds()
            if splitParagraphs.count > 0 {
                var index = 1
                for paragraph in splitParagraphs {
                    if (paragraph.isEmpty == true || paragraph == "\n" || paragraph == "<br>")
                    {
                        continue
                    }
                    if paragraph.isEmpty == false {
                        if index % 3 == 0 {
                            if index % 9 == 0 { //after every 2 medium ads, need a carousel of ads
                                var model = NewsDetailDataModel(type: .adCarousel, data: (nil, nil))
                                model.ads = ads
                                dataSource.append(model)
                                
                            } else { //after every 2 paragraphs, need a medium ad
                                var model = NewsDetailDataModel(type: .customAd, data: (nil, nil))
                                model.ads = ads
                                dataSource.append(model)
                            }
                        } else {
                            dataSource.append(NewsDetailDataModel(type: .paragraph, data: (paragraph, nil)))
                        }
                        index += 1
                    }
                }
            } else {
                dataSource.append(NewsDetailDataModel(type: .paragraph, data: (nil, nil)))
            }
        }
        
        return dataSource
    }
}

enum NewsDetailCellType {
    case topAd
    case header
    case imageWithCaption
    case paragraph
    case customAd
    case adCarousel
}
struct NewsDetailDataModel {
    var type: NewsDetailCellType
    var data: (String?, String?)
    var ads: [CustomAdModel]?
    
    init(type: NewsDetailCellType, data: (String?, String?)) {
        self.type = type
        self.data = data
    }
}
