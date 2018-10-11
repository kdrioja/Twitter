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
    var username: String?
    static var currentUser: User?
    
    //Initializer
    init(dictionary: [String: Any]) {
        name = dictionary["name"] as? String ?? ""
        username = dictionary["username"] as? String ?? ""
        
    }
    
}
