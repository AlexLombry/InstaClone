//
//  ViewController.swift
//  InstaClone
//
//  Created by Alex Lombry on 18/05/16.
//  Copyright © 2016 Alex Lombry. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    // Database reference from Firebase
    let ref = Firebase(url: "https://instaclone123.firebaseio.com")
    
    
    // MARK: - IBOutlet
    // Outlet for textfield
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Basic function
    func alertDialog() {
        
        let dialogAlert = UIAlertController(title: "Create new account", message: "", preferredStyle: .Alert)
        
        // create account
        let create = UIAlertAction(title: "Create", style: .Default) { (UIAlertAction) -> Void in
            let ident = dialogAlert.textFields![0];
            let email = dialogAlert.textFields![1];
            let pass = dialogAlert.textFields![2];
            
            // ! because everything is optional
            self.createUsers(ident.text!, email: email.text!, password: pass.text!)
        }
        
        // cancel action
        let cancel = UIAlertAction(title: "Cancel", style: .Default) { (action: UIAlertAction) -> Void in
            
        }
        
        dialogAlert.addTextFieldWithConfigurationHandler { (textIdent) -> Void in
            textIdent.placeholder = "Identity"
        }
        
        dialogAlert.addTextFieldWithConfigurationHandler { (textEmail) -> Void in
            textEmail.placeholder = "Email"
            textEmail.keyboardType = UIKeyboardType.EmailAddress
        }
        
        dialogAlert.addTextFieldWithConfigurationHandler { (textPass) -> Void in
            textPass.placeholder = "Password"
            textPass.secureTextEntry = true
        }

        dialogAlert.addAction(create)
        dialogAlert.addAction(cancel)
        
        presentViewController(dialogAlert, animated: true, completion: nil)
    }
    
    /**
     Create a user on Firebase database
     
     - parameter ident: User name
     
     - parameter email: User email address
     
     - parameter password: User password
     */
    func createUsers(ident: String, email: String, password: String) {
        
        ref.createUser(
            email,
            password: password,
            withValueCompletionBlock: { error, result in
                if error != nil {
                    // There was an error creating the account
                    
                } else {
                    let uid = result["uid"] as? String
                    print("Account created with id : \(uid)")
                }
            }
        )
        
    }
    
    /**
       Enable user to log in into our app via Firebase
     
     - parameter email: User email address
     
     - parameter password: User password
     */
    func login(email: String, password: String) {
        ref.authUser(email, password: password, withCompletionBlock: { error, authData in
            if error != nil {
                // There was an error logging in to this account
                print("User not found with this credentials")
            } else {
                // We are now logged in
                print("you are connected")
            }
        })
    }
    
    // MARK: - IBAction
    @IBAction func connection(sender: AnyObject) {
        login(emailField.text!, password: passField.text!)
    }
    
    @IBAction func createAccount(sender: AnyObject) {
        alertDialog()
    }

}

