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
    
    private let url = "http://feeds.reuters.com/reuters/businessNews"
    
    func parseRssUrl() {
        Alamofire.request(url).responseRSS { (response) in
            if let feed: RSSFeed = response.result.value {
                for item in feed.items {
                    print(item)
                }
            }
        }
    }
    
}
