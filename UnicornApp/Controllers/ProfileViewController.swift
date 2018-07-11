//
//  ProfileViewController.swift
//  UnicornApp
//
//  Created by Oleksii Liubarets on 09.07.18.
//  Copyright © 2018 Oleksii Liubarets. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var currentTimeLbl: UILabel!
    @IBOutlet weak var newsTitleLbl: UILabel!
    
    // MARK: Variables
    var timer = Timer()
    
    // MARK: ViewControllers's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkCurrentDateAndTime()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setPostTitle(_:)), name: .DidSelectPost, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        createTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer.invalidate()
    }
    // MARK: Setup post's title label
    @objc
    func setPostTitle(_ notification: Notification) {
        newsTitleLbl.text = notification.userInfo!["postTitle"] as? String
    }

    // MARK: Create timer for check current date and time
    @objc
    func checkCurrentDateAndTime() {
        
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        var timeForDisplaying = "Current date: \n\(day).\(month).\(year) \nCurrent time: \n\(hour):"
        if minutes < 10 {
            timeForDisplaying = timeForDisplaying + "0\(minutes):"
        } else {
            timeForDisplaying = timeForDisplaying + "\(minutes):"
        }
        if seconds < 10 {
            timeForDisplaying = timeForDisplaying + "0\(seconds)"
        } else {
            timeForDisplaying = timeForDisplaying + "\(seconds)"
        }
        
        currentTimeLbl.text = timeForDisplaying
    }
    
    func createTimer() {
        
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.checkCurrentDateAndTime), userInfo: nil, repeats: true)
    }

}

