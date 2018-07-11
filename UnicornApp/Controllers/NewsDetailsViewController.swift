//
//  NewsDetailsViewController.swift
//  UnicornApp
//
//  Created by Oleksii Liubarets on 10.07.18.
//  Copyright © 2018 Oleksii Liubarets. All rights reserved.
//

import UIKit

class NewsDetailsViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var authorLbl: UILabel!
    
    // MARK: Variables
    var news: NewsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupController()
    }
    
    // MARK: Setup Controller
    func setupController() {
        title = "Post detail"
        
        titleLbl.text = news?.title
        descriptionTV.text = news?.description
        authorLbl.text = news?.author
    }

}
