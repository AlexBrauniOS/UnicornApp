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
    enum NewsRubric: String {
        case business = "http://feeds.reuters.com/reuters/businessNews"
        case entertainment = "http://feeds.reuters.com/reuters/entertainment"
        case environment = "http://feeds.reuters.com/reuters/environment"
    }
    
    func getNews(rubric: NewsRubric, result: @escaping (_ news: [NewsModel], _ url: String) -> ()) {
        
        var url = ""
        
        switch rubric {
        case .business:
            url = NewsRubric.business.rawValue
        case .entertainment:
            url = NewsRubric.entertainment.rawValue
        case .environment:
            url = NewsRubric.environment.rawValue
        }
        
        Alamofire.request(url).responseRSS { (response) in
            if let feed: RSSFeed = response.result.value {
                let news = feed.items.map({ (item) -> NewsModel in
                    let title = item.title ?? "No title"
                    let description = item.itemDescription?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil) ?? "No Description"
//                    print("ITEM DESCRIPTION: \(item.itemDescription ?? "LOL")")
                    let author = item.author ?? "Unknown author"
                    
                    print("MY ITEM: \(item)")
                    
                    return NewsModel(title: title, description: description, author: author)
                })
                result(news, url)
            }
        }
    }
    
}
