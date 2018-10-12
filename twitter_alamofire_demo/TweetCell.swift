//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by user145766 on 10/11/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {

    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet?
    var user: User?
    var parentView: TimelineViewController?
    var indexPath: IndexPath?
    
    func updateAllFields() {
        if let tweet = self.tweet, let user = self.user {
            if let profilePhotoURL = user.profilePhoto {
                profilePictureImageView.af_setImage(withURL: profilePhotoURL)
            }
            dateLabel.text = tweet.createdAtString
            nameLabel.text = user.name
            usernameLabel.text = "@\(user.screenName!)"
            tweetLabel.text = tweet.text
            updateButtonCounts()
            //retweetCountLabel.text = (tweet.retweetCount as! String)
            //favoriteCountLabel.text = (tweet.favoriteCount as! String)
        }
    }
    
    func updateButtonCounts() {
        retweetButton.setTitle("\(tweet?.retweetCount! ?? 0)", for: .normal)
        favoriteButton.setTitle("\(tweet?.favoriteCount! ?? 0)", for: .normal)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        profilePictureImageView.layer.cornerRadius = 3
        profilePictureImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
