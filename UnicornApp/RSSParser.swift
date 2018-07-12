//
//  RSSParser.swift
//  UnicornApp
//
//  Created by Oleksii Liubarets on 09.07.18.
//  Copyright © 2018 Oleksii Liubarets. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireRSSParser

class RSSParser {
    
    // urls
    enum NewsRubric: String {
        case business = "http://feeds.reuters.com/reuters/businessNews"
        case entertainment = "http://feeds.reuters.com/reuters/entertainment"
        case environment = "http://feeds.reuters.com/reuters/environment"
    }
    
    func getNews(rubric: NewsRubric, result: @escaping (_ news: [NewsModel], _ url: String) -> ()) {
        
        var url = ""
        
        switch rubric { // select ulr's link
        case .business:
            url = NewsRubric.business.rawValue
        case .entertainment:
            url = NewsRubric.entertainment.rawValue
        case .environment:
            url = NewsRubric.environment.rawValue
        }
        
        Alamofire.request(url).responseRSS { (response) in
            if let feed: RSSFeed = response.result.value {
                let news = feed.items.map({ (item) -> NewsModel in // mapping rrs model to custom model (NewsModel)
                    let title = item.title ?? "No title"
                    let description = item.itemDescription?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil) ?? "No Description" // remove trash from description
                    let author = item.author ?? "Unknown author"
                    
                    return NewsModel(title: title, description: description, author: author)
                })
                result(news, url)
            }
        }
    }
    
}
