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
            self.updateButtonCounts(tweet)
            self.updateTweetIcons(tweet)
            //retweetCountLabel.text = (tweet.retweetCount as! String)
            //favoriteCountLabel.text = (tweet.favoriteCount as! String)
        }
    }
    
    func updateButtonCounts(_ tweet: Tweet) {
        retweetButton.setTitle("\(tweet.retweetCount!)", for: .normal)
        favoriteButton.setTitle("\(tweet.favoriteCount!)", for: .normal)
    }
    
    @IBAction func onRetweet(_ sender: Any) {
        if (tweet!.retweeted == false) {
            APIManager.shared.retweet(self.tweet!) { (post, error) in
                if let  error = error {
                    print("Error Retweeting Tweet: \(error.localizedDescription)")
                } else {
                    self.parentView?.fetchTweets()
                }
            }
        }
        else {
            APIManager.shared.unretweet(self.tweet!) { (post, error) in
                if let  error = error {
                    print("Error Retweeting Tweet: \(error.localizedDescription)")
                } else {
                    self.parentView?.fetchTweets()
                }
            }
        }
        self.updateTweetIcons(tweet!)
    }
    
    @IBAction func onFavorite(_ sender: Any) {
        if (tweet!.favorited == false) {
            APIManager.shared.favorite(self.tweet!) { (post, error) in
                if let  error = error {
                    print("Error Favoriting Tweet: \(error.localizedDescription)")
                } else {
                    self.parentView?.fetchTweets()
                }
            }
        }
        else {
            APIManager.shared.unfavorite(self.tweet!) { (post, error) in
                if let  error = error {
                    print("Error Favoriting Tweet: \(error.localizedDescription)")
                } else {
                    self.parentView?.fetchTweets()
                }
            }
        }
        
        self.updateTweetIcons(tweet!)
    }
    
    func updateTweetIcons(_ tweet: Tweet) {
        if (tweet.favorited! == true) {
            self.favoriteButton.setImage(UIImage(named: "favor-icon-red.png"), for: .normal)
        }
        else {
            self.favoriteButton.setImage(UIImage(named: "favor-icon.png"), for: .normal)
        }
        
        if (tweet.retweeted == true) {
            self.retweetButton.setImage(UIImage(named: "retweet-icon-green.png"), for: .normal)
        }
        else {
            self.retweetButton.setImage(UIImage(named: "retweet-icon.png"), for: .normal)
        }
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
