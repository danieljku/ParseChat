//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Daniel Ku on 2/23/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let currentUser = PFUser.current()
        if currentUser != nil {
            let chatVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "chatVC") as! ChatViewController
            chatVC.user = currentUser
            self.navigationController?.present(chatVC, animated: true, completion: nil)
        } else {
            // Show the signup or login screen
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alert(error: String){
        let alertController = UIAlertController(title: "Try Again", message: error, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK ", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }

    @IBAction func onLogin(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: username.text!, password: password.text!) { (user: PFUser?, error: Error?) in
            if let error = error {
                self.alert(error: error.localizedDescription)
                // Show the erro rString somewhere and let the user try again.
            } else {
                let chatVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "chatVC") as! ChatViewController
                chatVC.user = user
                self.present(chatVC, animated: true, completion: nil)
            }
        }
    }

}

