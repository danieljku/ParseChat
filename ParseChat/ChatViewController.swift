//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Daniel Ku on 2/23/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var chatMessage: UITextField!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var user: PFUser?
    var messages = [PFObject]()
    let query = PFQuery(className:"Message")


    override func viewDidLoad() {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ChatViewController.onTimer), userInfo: nil, repeats: true)

        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        getMessages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getMessages(){
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if error == nil {
                if let objects = objects {
                    self.messages.removeAll()
                    for object in objects {
                        self.messages.append(object)
                    }
                    self.tableView.reloadData()
                }
            } else {
                // Log details of the failure
                print("Error")
            }
            
        }
    }
    
    func onTimer() {
        query.order(byDescending: "createdAt")
        getMessages()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatTable", for: indexPath) as! ChatTableViewCell
        let message = messages[indexPath.row]
        
        cell.chatMessage.text = message["text"] as? String
        if let user = message["User"] as? PFUser{
            user.fetchInBackground(block: { (object: PFObject?, error: Error?) in
                if error == nil{
                    cell.username.text = "\(user.username!): "
                }
            })
        }else{
            cell.username.isHidden = true
        }

        
        return cell
    }

    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
        self.present(loginVC, animated: false, completion: nil)

    }

    @IBAction func onSend(_ sender: Any) {
        let message = PFObject(className:"Message")
        message["text"] = chatMessage.text
        message["User"] = PFUser.current()
        message.saveInBackground { (success: Bool, error: Error?) in
            if(success){
                self.messages.insert(message, at: 0)
                self.tableView.reloadData()
            }else{
                print(error!.localizedDescription)
            }
        }
    }


}
