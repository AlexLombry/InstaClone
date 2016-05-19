//
//  ContactViewController.swift
//  InstaClone
//
//  Created by Alex Lombry on 19/05/16.
//  Copyright © 2016 Alex Lombry. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    // contact list used on TableViewController (passes by segue)
    var contact: NSDictionary?
    // image url
    var imagePartnerUrl: String = "https://source.unsplash.com/random"
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var follow: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set delegate dataSource and background color for collection view
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // set collection view title
        self.title = "\(contact!["name"]!)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Datasource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    // Set images on the collection view to the downloaded one and return the cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellContact", forIndexPath: indexPath) as! CollectionViewCell
        
        self.downloadImages(self.imagePartnerUrl) { (data) in
            let image = UIImage(data: data)
            cell.imageView.image = image
        }
        
        return cell
    }
    
    // Download images from partner Random url
    func downloadImages(string:String, completion:(data: NSData) -> ()) {
        // set the url in string format
        let urlString = NSURL(string: string)
        
        // Create the request and make it asynchronous
        let request = NSURLSession.sharedSession().dataTaskWithURL(urlString!) { (data, response, error) -> Void in
            if error == nil {
                // asynchronous request to url
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if let dataImage = data {
                        completion(data: dataImage)
                    }
                })
            } else {
                print("Error dll images")
            }
        }
        
        // execute the request
        request.resume()
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    @IBAction func followContact(sender: AnyObject) {
        print("Follow \(contact!["name"]!)")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
