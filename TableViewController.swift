//
//  TableViewController.swift
//  InstaClone
//
//  Created by Alex Lombry on 18/05/16.
//  Copyright © 2016 Alex Lombry. All rights reserved.
//

import UIKit
import Firebase

class TableViewController: UITableViewController {
    // Database reference from Firebase
    let ref = Firebase(url: "https://instaclone123.firebaseio.com")
    let usersRef = Firebase(url: "https://instaclone123.firebaseio.com/users")
    var userRef: Firebase?
    
    var users = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        cell.textLabel?.text = "BanKai"

        return cell
    }

    // TODO: To change quickly
    func makeUsers(ident: String, email: String, password: String) {
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

}
