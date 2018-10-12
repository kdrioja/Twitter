//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by user145766 on 10/11/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import Foundation

class User {
    //Properties
    var userID: Int64?
    var name: String?
    var screenName: String?
    var profilePhoto: URL?
    var bannerPhoto: URL?
    var friendCount: Int?
    var followerCount : Int?
    var favoritesCount: Int?
    var statusCount : Int?
    
    //Initializer
    var dictionary: [String: Any]?
    init(dictionary: [String: Any]) {
        self.dictionary = dictionary
        name = dictionary["name"] as! String
        
        if let profile: String = dictionary["profile_image_url_https"] as? String {
            profilePhoto = URL(string: profile)!
        }
        
        if let banner: String = dictionary["profile_banner_url"] as? String {
            bannerPhoto = URL(string: banner)!
        }
        
        if let screen = dictionary["screen_name"] {
            screenName = screen as! String
        }
        
        friendCount = dictionary["friends_count"] as! Int
        followerCount = dictionary["followers_count"] as! Int
        statusCount = dictionary["statuses_count"] as! Int
        
        guard let id: NSNumber = dictionary["id"] as? NSNumber else {
            print("Twitter ID error")
            return
        }
        
        userID = id.int64Value
        favoritesCount = dictionary["favourites_count"] as! Int
    }
    
    // Current User
    private static var _current: User?
    static var current: User?{
        get{
            let defaults = UserDefaults.standard
            if let userData = defaults.data(forKey: "currentUserData"){
                let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
                return  User(dictionary: dictionary)
            }
            return nil
        }
        set(user){
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary, options: [])
                defaults.set(data, forKey: "currentUserData")
            }else{
                defaults.removeObject(forKey: "currentUserData")
            }
        }
    }
}
