
//  ViewController.swift
//  ChatApp
//
//  Created by Islam Gharib on 10/23/18.
//  Copyright © 2018 Gharib. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // initialize var as a referance of firebase database
    // FIRDatabaseReference is replaced with DatabaseReference in swift4
    var ref = DatabaseReference.init()
    
    @IBOutlet weak var chatTableView: UITableView!
    var listOfChatInfo = [Chat]()
    
    // determine according of data comming from loginVC using preferforsegue
    var UserName:String?
    @IBOutlet weak var chatTextTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.dataSource = self
        chatTableView.delegate = self
        loginAnony()
        
        // create instance of firbase database ->  don't forget to make the database rules of firebase true
        // FIRDatabase is replaced with Database
        self.ref = Database.database().reference()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfChatInfo.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ChatCell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! ChatCell
        cell.setChat(chat: listOfChatInfo[indexPath.row])
        return cell
    }
    
    func loadChatRoom(){
        // get the data from firebase and order it according to datePost
        self.ref.child("chat").queryOrdered(byChild: "postDate").observe(.value, with: {
            (snapshot) in // snapshot is the data expected to get from firebase
            // code here
            self.listOfChatInfo.removeAll() // remove all data into list array
            
            // get all child obj so snapshot contain keys and values -> FIRDataSnapshot replaced with DataSnapshot
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshot{
                    if let postData = snap.value as? [String:AnyObject]{
                        let userName = postData["name"] as? String
                        let text = postData["text"] as? String
                        var postDate:CLong?
                        
                        if let postDateIn = postData["postDate"] as? CLong{
                            postDate = postDateIn
                        }
                        self.listOfChatInfo.append(Chat(userName: userName!, text: text!, datePost: "\(postDate)"))
                    }
                }
                self.chatTableView.reloadData()
                
                // every new message placed at the end
                let indexPath = IndexPath(row: self.listOfChatInfo.count-1, section: 0)
                self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        })
    }

    // login using Anonymous Authentication of firebase
    func loginAnony(){
        // FIRAuth is replaced by Auth in swift4
        Auth.auth().signInAnonymously(){
            (user,error) in
            // code here
            if let error = error{
                print("Can't Login: \(error)")
            }else{
                // // uid is replaced user.uid in swift 4
                print("User UID \(user?.user.uid)")
                // invoke loadChatRoom after it login
                self.loadChatRoom()
            }
        }
    }

    @IBAction func sendToChatRoom(_ sender: Any) {
        // FIRServerValue is replaced with ServerValue
        let dic = ["text" : chatTextTF.text, "name" : UserName!, "postDate" : ServerValue.timestamp()] as [String : Any]
        
        //  self.ref.child("chat").setValue(dic) -> this ref.child updated the data and save only one branch of child
        self.ref.child("chat").childByAutoId().setValue(dic) // -> this ref.child.childByAutoId update the recent data and save it with the old data on more branches of child
        self.chatTextTF.text = ""
    }
}

