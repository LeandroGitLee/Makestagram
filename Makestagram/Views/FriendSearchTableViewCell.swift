//
//  FriendSearchTableViewCell.swift
//  Makestagram
//
//  Created by Santi on 7/2/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse

protocol FriendSearchTableViewCellDelegate : class {
    func cell (cell: FriendSearchTableViewCell, didSelectFollowUser user: PFUser)
    func cell (cell: FriendSearchTableViewCell, didSelectUnFollowUser user: PFUser)
}

class FriendSearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    weak var delegate: FriendSearchTableViewCellDelegate?
    
    var user: PFUser? {
        didSet {
            usernameLabel.text = user?.username
        }
    }
    
    var canFollow: Bool? = true {
        didSet {
            if let canFollow = canFollow {
                followButton.selected = !canFollow
            }
        }
    }
    
    
    @IBAction func followButtonTapped (sender: AnyObject) {
        if let canFollow = canFollow where canFollow == true {
            delegate?.cell(self, didSelectFollowUser: user!)
            self.canFollow = false
        } else {
            delegate?.cell(self, didSelectUnFollowUser: user!)
            self.canFollow = true
        }
    }
    
    
}
