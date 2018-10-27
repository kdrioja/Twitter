//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by user145766 on 10/26/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

protocol ComposeViewControllerDelegate: class {
    func did(post: Tweet)
}

class ComposeViewController: UIViewController {
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UITextView!
    @IBOutlet weak var charsRemainingLabel: UILabel!
    
    weak var delegate: ComposeViewControllerDelegate?
    var parentView: TimelineViewController?
    let charLimit: Int = 140
    
    var isReply: Bool = false
    var replyUsername: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profilePictureURL = User.current?.profilePhoto
        profilePictureImageView.af_setImage(withURL: profilePictureURL!)
        nameLabel.text = User.current?.name
        usernameLabel.text = "@\(User.current?.screenName ?? "username")"
        
        
    }
    
    @IBAction func onTapPost(_ sender: Any) {
        let tweetText = tweetLabel.text!
        //"This is my tweet 😀"
        APIManager.shared.composeTweet(with: tweetText) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
            }
        }
        performSegue(withIdentifier: "returnTimelineSegue", sender: nil)
    }
    
    @IBAction func onTapCancel(_ sender: Any) {
        performSegue(withIdentifier: "returnTimelineSegue", sender: nil)
    }
    
    func did(tweet: Tweet) {
        
    }
    /*
    override func awakeFromNib() {
        super.awakeFromNib()
        profilePictureImageView.layer.cornerRadius = 3
        profilePictureImageView.clipsToBounds = true
    }
 */
}
