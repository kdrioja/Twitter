//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Aristotle on 2018-08-11.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.updateUserInfo()
        
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchTweets), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        self.fetchTweets()
    }
    
    @IBAction func onLogout(_ sender: Any) {
        APIManager.shared.logout()
    }
    
    @IBAction func onProfile(_ sender: Any) {
    }
    
    @IBAction func onCompose(_ sender: Any) {
    }
    
    func fetchTweets() {
        APIManager.shared.getHomeTimeLine { (tweets: [Tweet]?, error: Error?) in
            if let error = error {
                print("Couldn't fetch tweets")
                print(error.localizedDescription)
            }
            else {
                self.tweets = tweets!
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    func updateUserInfo() {
        APIManager.shared.getCurrentAccount { (user: User?, error: Error?) in
            if let error = error {
                print("Couldn't update user info")
                print(error.localizedDescription)
            }
            if let user = user {
                User.current = user
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        let tweet  = tweets[indexPath.row]
        cell.tweet = tweet
        cell.user = tweet.user
        cell.indexPath = indexPath
        cell.updateAllFields()
        cell.parentView = self as TimelineViewController
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func did(post: Tweet) {
        updateUserInfo()
        fetchTweets()
    }
}
