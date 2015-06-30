//
//  Post.swift
//  Makestagram
//
//  Created by Santi on 6/30/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import Foundation
import Parse

class Post : PFObject, PFSubclassing {
    
    @NSManaged var imageFile: PFFile?
    @NSManaged var user: PFUser?
    
    var photoUploadTask: UIBackgroundTaskIdentifier?
    
    var image: UIImage?
    
    //MARK: PFSubclassing protocol
    
    static func parseClassName() -> String {
        return "Post"
    }
    
    override init () {
        super.init()
    }
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }

    ////////////////////////// all the previous code is coming from Parse to subclass
    
    ///// writing my own method
    
    func uploadPost () {
     let imageData = UIImageJPEGRepresentation(image, 0.8)
        let imageFile = PFFile(data: imageData)
        imageFile.saveInBackgroundWithBlock(nil)
        
        
        //1 
        photoUploadTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler { () -> Void in
            UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
        }
        
        
        //2
        imageFile.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
        }
        
        
        
        user = PFUser.currentUser() // user is part of the Post class, here we assign to the current user on the session at Parse... our post will show the user that is posting the image
        
        self.imageFile = imageFile
        saveInBackgroundWithBlock(nil) // nil because now I don't want to get informed when the upload to parse is completed...
    }
    
    
}