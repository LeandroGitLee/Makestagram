//
//  TimelineViewController.swift
//  Makestagram
//
//  Created by Santi on 6/29/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse


class TimelineViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var photoTakingHelper: PhotoTakingHelper?
    var posts : [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // we need to set the delegate for the extension of the class
        self.tabBarController?.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // every time the TimeLine appears we are gonna query Parse to retrieve Posts from other users
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        ParseHelper.timelineRequestforCurrentUser {
            (result: [AnyObject]?, error: NSError?) -> Void in
            self.posts = result as? [Post] ?? []
            
            self.tableView.reloadData()
        }
    }
        
    
    func takePhoto() {
        // instantiate photo taking class, provide callback for when photo is selected
        photoTakingHelper =
            PhotoTakingHelper(viewController: self.tabBarController!) { (image: UIImage?) in
                let post = Post()
                // 1
                post.image.value = image!
                post.uploadPost()
        }
    }
    
}


// MARK: Tab bar delegate

extension TimelineViewController : UITabBarControllerDelegate {
    
        func tabBarController (tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
            
            if (viewController is PhotoViewController) {
                println("Take Photo")
                takePhoto()
                return false
            } else {
                return true
            }
        
    }
}


// We established that the data source for the TableView will be this class
// We are gonna write an extension to conform the protocol of UITableViewDataSource


extension TimelineViewController : UITableViewDataSource {
    
    
    // conforming the protocol @required... returning the number of rows per section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    
    }

    // same here, creating the cell and returning it
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostTableViewCell
        
        let post = posts[indexPath.row]
        post.downloadImage()
        post.fetchLikes()
        cell.post = post
        
        return cell
    }
    
}

