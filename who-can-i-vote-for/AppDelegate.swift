//
//  AppDelegate.swift
//  who-can-i-vote-for
//
//  Created by Dylan McKee on 31/03/2015.
//  Copyright (c) 2015 djmckee. All rights reserved.
//

import UIKit
import ReachabilitySwift
import SwiftSpinner

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        

        do {
            // Start reachability warnings (so that they're app-wide)
            let reachability = Reachability.init()!
            
            reachability.whenUnreachable = { reachability in
                //print("Internet is not reachable :'(")
                // alert the user...
                let alertController = UIAlertController(title: "No internet connection", message: "We're sorry but this app requires data from the Internet. Please check your Internet connection and try again.", preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
                alertController.addAction(cancelAction)
                
                self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
            }
            
            try reachability.startNotifier()
        } catch {
            // TODO: Handle Reachability exceptions here. Maybe. One day.
        }
        
        
        
        // Style our app-wide status bar
        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: false)

        
        return true
    }
    
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

