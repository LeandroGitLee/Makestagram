//
//  AppDelegate.swift
//  Makestagram
//
//  Created by Benjamin Encz on 5/15/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    

    // keys from parse
    Parse.setApplicationId("FbnYEsYbEGg9lMBNrKtwmPczCIIKDuXkHPCkLhnI", clientKey: "yiOh1wTpV61je7o8h100YmpTYOsMf8gofxIGP2qi")
    
    // Parse.initialize() // suggested on livecoding.tv mavdev
    
    PFUser.logInWithUsername("testing", password: "testing") // this is gonna return an optional, so we need to check
    // on the next line if its not nil, if it is show on the terminal...
    
    //PFUser.enableRevocableSessionInBackground()
    //suggested by stackoverflow http://stackoverflow.com/questions/29423344/parse-invalid-session-token-code-209-version-1-7-1
    
    if let user = PFUser.currentUser() {
        println("yay! logged in") // its not nil
    } else {
        println("sorry bro!") // no user... PFUser is nil
    }
    
    return true
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}

