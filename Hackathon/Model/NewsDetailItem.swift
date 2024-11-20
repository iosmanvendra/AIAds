//
//  NewsDetailItem.swift
//  Hackathon
//
//  Created by Arige Maheswari (Digital Business - Technology- Visakhapatnam) on 20/11/24.
//

import SwiftyJSON

struct NewsDetailItemData: Codable {
    let content: NewsDetailItem
}

struct NewsDetailItem: Codable {
    let sectionName, sectionUrl, newsBelongsTo: String?
    let deleted: Bool?
    let sectionItems: SectionItem?
}

struct SectionItem: Codable {
    let contentType, websiteURL, headLine, itemId, authorName, agencyName, city, publishedDate, lastModified, longHeadline, storyText, primaryParentCategory, thumbImage, mediumRes, wallpaperLarge, emailAuthor, videoScript, caption, keywords, audioSourceURL: String?
    let exclusiveStory: Bool?
}
