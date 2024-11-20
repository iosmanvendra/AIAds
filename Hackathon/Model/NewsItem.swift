//
//  NewsItem.swift
//  Hackathon sample app
//
//  Created by Arige Maheswari (Digital Business - Technology- Visakhapatnam) on 18/11/24.
//


import SwiftyJSON
struct NewsItemData: Codable {
    let data: [NewsItem]
}

//enum ContentType: String, Codable {
//    case News
//}

struct NewsItem: Codable {
    let blog, itemId, section, deadlink, headLine, keywords, mediumRes, agencyName, subSection, thumbImage, websiteURL, contentType, displayHtml, externalURL, detailFeedURL, isPromotional, publishedDate, audioSourceURL, displayHtmlurl, mobileHeadline, wallpaperLarge, shortDescription: String?
    let exclusiveStory: Bool?
//    let contentType: ContentType?
    let timeToRead: Int?
}
