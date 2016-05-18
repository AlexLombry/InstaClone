//
//  ViewController.swift
//  InstaClone
//
//  Created by Alex Lombry on 18/05/16.
//  Copyright © 2016 Alex Lombry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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

    func alertDialog() {
        
        let dialogAlert = UIAlertController(title: "Create new account", message: "", preferredStyle: .Alert)
        
        // create account
        let create = UIAlertAction(title: "Create", style: .Default) { (UIAlertAction) -> Void in
            let ident = dialogAlert.textFields![0];
            let email = dialogAlert.textFields![1];
            let pass = dialogAlert.textFields![2];
            
            print("compte créer pour \(ident.text) \(email.text) \(pass.text)")
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
    
    @IBAction func connection(sender: AnyObject) {
        
    }
    
    /// Pragma mark: Create an Account
    @IBAction func createAccount(sender: AnyObject) {
        alertDialog()
    }

}

