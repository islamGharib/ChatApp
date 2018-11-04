//
//  LoginVC.swift
//  ChatApp
//
//  Created by Islam Gharib on 10/28/18.
//  Copyright © 2018 Gharib. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var userNameTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func loginBtn(_ sender: Any) {
        performSegue(withIdentifier: "chatRoom", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chatRoom"{
            if let dest = segue.destination as? ViewController{
                dest.UserName = userNameTF.text
            }
        }
    }
}
