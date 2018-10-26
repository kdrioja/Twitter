//
//  TweetDetailsViewController.swift
//  twitter_alamofire_demo
//
//  Created by user145766 on 10/26/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {

    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var selectedTweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}
