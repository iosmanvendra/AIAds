//
//  CustomAdModel.swift
//  Hackathon
//
//  Created by Arige Maheswari (Digital Business - Technology- Visakhapatnam) on 20/11/24.
//

import SwiftyJSON

struct CustomAdModel: Codable {
    let title, subTitle, bannerUrl: String?
    let category: [String]?
    let subCategory: [String]?
    let subSubCategory: [String]?
    
    enum CodingKeys: String, CodingKey {
        case title
        case subTitle = "description"
        case bannerUrl = "banner_url"
        case category
        case subCategory = "sub_category"
        case subSubCategory = "sub_to_sub_category"
    }
}
