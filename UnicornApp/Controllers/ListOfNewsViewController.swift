//
//  ListOfNewsViewController.swift
//  UnicornApp
//
//  Created by Oleksii Liubarets on 10.07.18.
//  Copyright © 2018 Oleksii Liubarets. All rights reserved.
//

import UIKit
import AlamofireRSSParser

class ListOfNewsViewController: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    let rssParser = RSSParser.shared
    
    var allNews: [NewsModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        rssParser.parseRssUrl(rubric: "business")
        getNews()
    }
    
    func getNews() {
        
        rssParser.callBack = { [unowned self] news in
            self.allNews = self.rssParser.getArrayWithNews(feeds: news)
        }
        
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails" {
            if let detailsVC = segue.destination as? NewsDetailsViewController {
                detailsVC.news = sender as? NewsModel
            }
        }
    }

}

extension ListOfNewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell") as! NewsTableViewCell
        
        cell.titleLbl.text = allNews[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let news = allNews[indexPath.row]
        
        self.performSegue(withIdentifier: "toDetails", sender: news)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}
