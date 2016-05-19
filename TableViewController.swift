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
    let followsRef = Firebase(url: "https://instaclone123.firebaseio.com/follows")
    

    var users = [NSDictionary]()
    var follows = [NSDictionary]()
    var array = [NSDictionary]()
    
    
    @IBOutlet weak var ctrlOrder: UISegmentedControl!

    @IBAction func ctrlSegmentUpdate(sender: AnyObject) {
        refreshData()
    }
    
    func refreshData() {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ctrlOrder.addTarget(self, action: #selector(TableViewController.refreshData), forControlEvents: .TouchUpInside)
        
        // get all account from Firebase
        queryFirebase()
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
        //return users.count
        
        if ctrlOrder.selectedSegmentIndex == 0 {
            array = users
        } else {
            array = follows
        }
        
        return array.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        let ident = users[indexPath.row]["name"] as! String
        let avatar = users[indexPath.row]["avatar"] as! String
        
        cell.textLabel?.text = ident
        cell.imageView!.image = UIImage(named: avatar)

        return cell
    }

    func queryFirebase() {
        
        // Attach a closure to read the data at our posts reference
        usersRef.observeEventType(.Value, withBlock: { snapshot in
            var tmp = [NSDictionary]()
            
            for user in snapshot.children {
                let item = user as! FDataSnapshot
                let dictionary = item.value as! NSDictionary
                tmp.append(dictionary)
            }
            
            // assign globally all users from Firebase
            self.users = tmp
            self.tableView.reloadData()
            
            }, withCancelBlock: { error in
                print(error.description)
        })
    }
    
    /*func addContact() {
        for i in 1 ..< 21 {
            let name: String = "user\(i)"
            let u = usersRef.childByAppendingPath(name)
            let user: NSDictionary = [
                "name" : name,
                "email": "\(name)@site.com",
                "avatar": "avatar\(i).jpg",
                "suivi": "non"
            ]
            
            u.setValue(user)
            makeUsers(name, email: "\(name)@site.com", password: "xxxx\(i)")
            users.append([
                "name" : name,
                "email": "\(name)@site.com",
                "avatar": "avatar\(i).jpeg",
                "suivi": "non"
            ])
        }
    }*/
    
    // TODO: To change quickly
    func makeUsers(ident: String, email: String, password: String) {
        ref.createUser(
            email,
            password: password,
            withValueCompletionBlock: { error, result in
                if error != nil {
                } else {
                    print("Successfully created user account with uid: \(ident)")
                }
            }
        )
    }
    
    // send information to segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let index = tableView.indexPathForSelectedRow
        let contactSelected = users[(index!.row)]
        
        let contactVC = segue.destinationViewController as! ContactViewController
        contactVC.contact = contactSelected
        
    }

    
    
    
    
    
    
    
    
    
    
    
}
