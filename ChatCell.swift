//
//  ChatCell.swift
//  ChatApp
//
//  Created by Islam Gharib on 10/29/18.
//  Copyright © 2018 Gharib. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    @IBOutlet weak var userNameLB: UILabel!
    @IBOutlet weak var textTV: UITextView!
    
    func setChat(chat:Chat){
        userNameLB.text = chat.userName
        textTV.text = chat.text
    }
    
}
