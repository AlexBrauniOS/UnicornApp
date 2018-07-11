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
    
    let rssParser = RSSParser()
    
    var displayingNews: [[NewsModel]] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var businessNews: [NewsModel] = []
    var entertainmentNews: [NewsModel] = []
    var environmentNews: [NewsModel] = []
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        title = "News"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupRssDownloader()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer.invalidate()
    }
    
    func setupRssDownloader() {
        
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(downloadNews), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    @objc
    func downloadNews() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let group = DispatchGroup()
        
        group.enter()
        rssParser.getNews(rubric: .business) { (news, url) in
            print("business: \(url)")
            print("////////////////")
            self.businessNews = news
            self.checkAndReloadData()
            group.leave()
        }
        group.enter()
        rssParser.getNews(rubric: .entertainment) { (news, url) in
            print("Entertainment: \(url)")
            print("////////////////")
            self.entertainmentNews = news
            group.leave()
        }
        group.enter()
        rssParser.getNews(rubric: .environment) { (news, url) in
            print("Environment: \(url)")
            print("////////////////")
            self.environmentNews = news
            group.leave()
        }
        
        group.notify(queue: .main) {
            print("ALL TASKS ARE DONE")
            self.checkAndReloadData()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        
    }
    
    func checkAndReloadData() {
        
        displayingNews.removeAll()
        
        if segmentControl.selectedSegmentIndex == 0 {
            displayingNews.append(businessNews)
        } else {
            displayingNews.append(entertainmentNews)
            displayingNews.append(environmentNews)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
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
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        
        checkAndReloadData()
        
    }
    

}

extension ListOfNewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return displayingNews.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if segmentControl.selectedSegmentIndex == 0 {
            return "Business news"
        } else {
            return section == 0 ? "Entertainment news" : "Environment news"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayingNews[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell") as! NewsTableViewCell
        
        cell.titleLbl.text = displayingNews[indexPath.section][indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let news = displayingNews[indexPath.section][indexPath.row]
        
        NotificationCenter.default.post(name: .DidSelectPost, object: nil, userInfo: ["postTitle": news.title])
        
        self.performSegue(withIdentifier: "toDetails", sender: news)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}
