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

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UITextView!
    @IBOutlet weak var charsRemainingLabel: UILabel!
    @IBOutlet weak var postButton: UIBarButtonItem!
    
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
        
        //postButton.isEnabled = false
        //tweetLabel.textColor = UIColor.lightGray
        tweetLabel.delegate = self
        
        if (isReply), let replyUsername = self.replyUsername {
            //tweetLabel.textColor = UIColor.black
            tweetLabel.text = "@\(replyUsername) "
            
            let newText = NSString(string: tweetLabel.text!)
            charsRemainingLabel.text = String(charLimit - newText.length)
        }
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
    
    @IBAction func onTapElsewhere(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        // Set the max character limit
        let characterLimit = 140
        
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        
        // TODO: Update Character Count Label
        charsRemainingLabel.text = String(charLimit - newText.count)
        
        // The new text should be allowed? True/False
        return newText.count < characterLimit
        
        /*
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        let current = newText.count
        
        //charsRemainingLabel.text = "\(charLimit - current)"
        if (current == 0) {
            charsRemainingLabel.textColor = UIColor.lightGray
            postButton.isEnabled = false
        }
        else if (current <= charLimit) {
            charsRemainingLabel.textColor = UIColor.lightGray
            postButton.isEnabled = true
        }
        else {
            postButton.isEnabled = false
            charsRemainingLabel.textColor = UIColor.red
        }
        charsRemainingLabel.text = "\(current)"
        
        return current <= charLimit
         */
    }
    
    func textViewDidBeginEditing(_ tweetLabel: UITextView) {
        if (tweetLabel.textColor == UIColor.lightGray) {
            tweetLabel.text = nil
            tweetLabel.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ tweetLabel: UITextView) {
        if (tweetLabel.text.count == 0) {
            tweetLabel.text = "Write a post..."
            tweetLabel.textColor = UIColor.lightGray
            postButton.isEnabled = true
        }
    }
    
    func did(tweet: Tweet) {
        
    }
}
