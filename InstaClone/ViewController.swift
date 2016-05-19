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
    var loggedIn: Bool = false
    
    // MARK: - IBOutlet TextField
    // Outlet for textfield
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    
    // MARK: - IBOutlet Button
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var newAccountBtn: UIButton!
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var enterBtn: UIButton!
    
    @IBOutlet weak var errorLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Check if user is connected or not
        ref.observeAuthEventWithBlock({ authData in
            if authData != nil {
                self.loggedIn = true
            } else {
                self.loggedIn = false
            }
            self.switchButton(self.loggedIn)
        })
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
            
            if (ident.text != "" && email.text != "" && pass.text != "") {
                self.createUsers(ident.text!, email: email.text!, password: pass.text!)
            }
            
            // ! because everything is optional
            self.createUsers(ident.text!, email: email.text!, password: pass.text!)
        }
        
        // cancel action
        let cancel = UIAlertAction(title: "Cancel", style: .Default) { (action: UIAlertAction) -> Void in
            
        }
        
        // MARK: Output configuration
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
                    
                    self.loggedIn = true
                    self.switchButton(self.loggedIn)
                    self.errorLbl.text = "Account created"
                    self.errorLbl.hidden = false
                    
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
                self.errorLbl.text = "User not found"
                self.errorLbl.hidden = false
            } else {
                // We are now logged in
                self.loggedIn = true
                self.switchButton(self.loggedIn)
            }
        })
    }
    
    /*
     Logout the user
     */
    func logout() {
        self.loggedIn = false
        self.switchButton(self.loggedIn)
        ref.unauth()
    }
    
    /*
     Switch button between auth status
     */
    func switchButton(loggedIn: Bool) {
        if loggedIn {
            self.errorLbl.text = ""
            self.errorLbl.hidden = true
            
            self.loginBtn.hidden = true
            self.newAccountBtn.hidden = true
            
            // disabled it
            self.loginBtn.enabled = false
            self.newAccountBtn.enabled = false
            
            self.logoutBtn.hidden = false
            self.enterBtn.hidden = false
            
            self.logoutBtn.enabled = true
            self.enterBtn.enabled = true
        } else {
            self.loginBtn.hidden = false
            self.newAccountBtn.hidden = false
            
            // disabled it
            self.loginBtn.enabled = true
            self.newAccountBtn.enabled = true
            
            self.logoutBtn.hidden = true
            self.enterBtn.hidden = true
            
            self.logoutBtn.enabled = false
            self.enterBtn.enabled = false
        }
    }
    
    // MARK: - IBAction
    @IBAction func connection(sender: AnyObject) {
        login(emailField.text!, password: passField.text!)
    }
    
    @IBAction func createAccount(sender: AnyObject) {
        alertDialog()
    }

    @IBAction func logout(sender: AnyObject) {
        logout()
    }
    
    /// User can enter only if he use this action
    @IBAction func enter(sender: AnyObject) {
        self.performSegueWithIdentifier("home", sender: self)
    }
}