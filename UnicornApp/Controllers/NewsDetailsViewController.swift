//
//  NewsDetailsViewController.swift
//  UnicornApp
//
//  Created by Oleksii Liubarets on 10.07.18.
//  Copyright © 2018 Oleksii Liubarets. All rights reserved.
//

import UIKit

class NewsDetailsViewController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var authorLbl: UILabel!
    
    var news: NewsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Post detail"
        
        titleLbl.text = news?.title
        descriptionTV.text = news?.description
        authorLbl.text = news?.author
        
    }

}
