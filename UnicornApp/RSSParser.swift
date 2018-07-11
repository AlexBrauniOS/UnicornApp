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
    
    static let shared = RSSParser() // singleton
    
//    private let url = "http://feeds.reuters.com/reuters/businessNews"

    var callBack: ((RSSFeed)->())?
    
    func parseRssUrl(rubric: String) {
        
        var url = ""
        
        switch rubric {
        case "business":
            url = "http://feeds.reuters.com/reuters/businessNews"
        case "entertainment":
            url = "http://feeds.reuters.com/reuters/entertainment"
        case "environment":
            url = "http://feeds.reuters.com/reuters/environment"
        default:
            break
        }
        
        Alamofire.request(url).responseRSS { (response) in
            if let feed: RSSFeed = response.result.value {
//                for item in feed.items {
//                    print(item)
//                }
                self.callBack?(feed)
            }
        }
    }
    
    func getArrayWithNews(feeds: RSSFeed?) -> [NewsModel] {
        
        var newsArr: [NewsModel] = []
        
        for item in (feeds?.items)! {
            let title = item.title ?? "No title"
            let description = item.description
            let author = item.author
            
            let news = NewsModel(title: title, description: description, author: author)
            
            newsArr.append(news)
        }
        
        
//        if let feed = feeds {
//
//            let title = feed.title ?? "No title"
//            let description = feed.description
//
//            let news = NewsModel(title: title, description: description, author: nil)
//
//            newsArr.append(news)
//        }
        
        return newsArr
    }
    
}
