//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by user145766 on 11/16/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = User.current {
            profilePictureImageView.af_setImage(withURL: user.profilePhoto!)
            nameLabel.text = user.name
            usernameLabel.text = "@\(user.screenName!)"
            tweetCountLabel.text = "\(user.statusCount!)"
            followersCountLabel.text = "\(user.followerCount!)"
            followingCountLabel.text = "\(user.friendCount!)"
        }
        /*
        profilePictureImageView.af_setImage(withURL: (User.current?.profilePhoto)!)
        nameLabel.text = User.current?.name
        usernameLabel.text = "@\(String(describing: User.current?.screenName!))"
        tweetCountLabel.text = "\(String(describing: User.current?.statusCount!))"
        followersCountLabel.text = "\(String(describing: User.current?.followerCount!))"
        followingCountLabel.text = "\(String(describing: User.current?.friendCount!))"
        */
 }
}
