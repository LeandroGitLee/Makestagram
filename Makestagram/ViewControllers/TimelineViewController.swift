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

    
    var photoTakingHelper: PhotoTakingHelper?

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
    
    func takePhoto () {
        
        // instantiate photo taking class, provide callback for when photo  is selected
        
        photoTakingHelper = PhotoTakingHelper(viewController: self.tabBarController!) { (image: UIImage?) in
            
            // we have the image coming from the Picker, we need to upload it to Parse...
            println("received a callback!!")
            
            // subclassed in Post.swift
            let post = Post()
            post.image = image
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
