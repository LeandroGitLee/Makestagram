//
//  ParseHelper.swift
//  Makestagram
//
//  Created by Santi on 6/30/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import Foundation
import Parse

// 1
class ParseHelper {
    
    
    static let ParseFollowClass = "Follow"
    static let ParseFollowFromUser = "fromUser"
    static let ParseFollowToUser = "toUser"
    
    static let ParseLikeClass = "Like"
    static let ParseLikeToPost = "toPost"
    static let ParseLikeFromUser = "fromUser"
    
    static let ParsePostUser = "user"
    static let ParsePostCreatedAt = "createdAt"
    
    static let ParseFlaggedContentClass = "FlaggedContent"
    static let ParseFlaggedContentFromUser = "fromUser"
    static let ParseFlaggedContentToPost = "toPost"
    static let ParseUserUsername = "username"
    
    
    
    // 2
    static func timelineRequestforCurrentUser(completionBlock: PFArrayResultBlock) {
        let followingQuery = PFQuery(className: ParseFollowClass)
        followingQuery.whereKey(ParseFollowFromUser, equalTo:PFUser.currentUser()!)
        
        let postsFromFollowedUsers = Post.query()
        postsFromFollowedUsers!.whereKey(ParsePostUser, matchesKey: ParseFollowToUser, inQuery: followingQuery)
        
        let postsFromThisUser = Post.query()
        postsFromThisUser!.whereKey(ParsePostUser, equalTo: PFUser.currentUser()!)
        
        let query = PFQuery.orQueryWithSubqueries([postsFromFollowedUsers!, postsFromThisUser!])
        query.includeKey(ParsePostUser)
        query.orderByDescending(ParsePostCreatedAt)
        
        // 3
        query.findObjectsInBackgroundWithBlock(completionBlock)
        
        
    }
    
    
    // function to perfom a like to a post from a user in the background

    static func likePost (user: PFUser, post: Post) {
        let likeObject = PFObject(className: ParseLikeClass) //creating an instance of a like (parse class)
        
        //defining the user that tab the like and the Post they liked
        likeObject[ParseLikeFromUser] = user
        likeObject[ParseLikeToPost] = post
        
        //saving that object to Parse in the background
        likeObject.saveInBackgroundWithBlock(nil)
    }
    
    
    // function to delete a like to a post from a user in the background
    
    static func unlikePost (user: PFUser, post: Post) {
        
        let query = PFQuery(className: ParseLikeClass)
        query.whereKey(ParseLikeFromUser, equalTo: user)
        query.whereKey(ParseLikeToPost, equalTo: post)
        query.findObjectsInBackgroundWithBlock {
            (results: [AnyObject]?, error: NSError?) -> Void in
            if let result = results as? [PFObject] {
                for likes in result {
                    likes.deleteInBackgroundWithBlock(nil)
                }
            }
            
        }
    }
    
    
    // function to retrieve all the likes for a given post
    
    static func likesForPost (post: Post, completionBlock: PFArrayResultBlock) {
        let query = PFQuery(className: ParseLikeClass)
        query.whereKey(ParseLikeToPost, equalTo: post)
        query.includeKey(ParseLikeFromUser)
        query.findObjectsInBackgroundWithBlock(completionBlock)
        
    }
    
}



extension PFObject : Equatable {
    
}

public func ==(lhs: PFObject, rhs: PFObject) -> Bool {
    return lhs.objectId == rhs.objectId
}