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
    var name: String?
    var screenName: String?
    static var current: User?
    
    //Initializer
    init(dictionary: [String: Any]) {
        name = dictionary["name"] as? String ?? ""
        screenName = dictionary["screen_name"] as? String ?? ""
        
    }
    
}
