//
//  SignUpViewController.swift
//  ParseChat
//
//  Created by Daniel Ku on 2/23/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!

    let user = PFUser()

    func alert(error: String){
        let alertController = UIAlertController(title: "Try Again", message: error, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK ", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onSignUp(_ sender: Any) {
        if let name = username.text{
            user.username = name
        }else{
            alert(error: "You didn't enter in a username!")
        }
        
        if password.text == nil{
            alert(error: "You didn't enter in a password!")
        }else{
            user.password = password.text
        }
        
        if password.text != confirmPassword.text{
            //do alert
            alert(error: "Passwords are not the same!")
        }
        
        if let email = email.text{
            user.email = email
        }else{
            alert(error: "You didn't enter in an email!")
        }
        
        user.signUpInBackground { (succeeded: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                self.alert(error: error.localizedDescription)
                // Show the errorString somewhere and let the user try again.
            } else {
                // Hooray! Let them use the app now.
                let chatVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "chatVC") as! ChatViewController
                chatVC.user = self.user
                self.navigationController?.present(chatVC, animated: true, completion: nil)
            }
            
        }
    }
    
}
