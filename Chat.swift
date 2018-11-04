
//  Chat.swift
//  ChatApp
//
//  Created by Islam Gharib on 10/29/18.
//  Copyright © 2018 Gharib. All rights reserved.
//

import UIKit

class Chat{
    var userName:String?
    var text:String?
    var datePost:String?
    
    init(userName:String, text:String, datePost:String) {
        self.userName = userName
        self.text = text
        self.datePost = datePost
    }
}
