//
//  AppDelegate.swift
//  who-can-i-vote-for
//
//  Created by Dylan McKee on 31/03/2015.
//  Copyright (c) 2015 djmckee. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // Register for notifications...
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes:UIUserNotificationType.Alert, categories: nil))
        
        // Start reachability warnings (so that they're app-wide)
        let reachability = Reachability.reachabilityForInternetConnection()
        
        reachability.whenUnreachable = { reachability in
            println("Internet is not reachable :'(")
            // alert the user...            
            let alertController = UIAlertController(title: "No internet connection", message: "We're sorry but this app requires data from the Internet. Please check your Internet connection and try again.", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Okay", style: .Default, handler: nil)
            alertController.addAction(cancelAction)
            
            self.window?.rootViewController?.presentViewController(alertController, animated: true, completion: nil)
        }
        
        reachability.startNotifier()
        
        // Style our app-wide status bar
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)

        
        return true
    }
    
    func application(application: UIApplication!, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings!) {
        // check NSUserDefaults - if it's a first launch, schedule a notification to remind teh user to vote!
        let defaults = NSUserDefaults.standardUserDefaults()
        let launchedBeforeKey = "launchedBefore"
        var launchedBefore:Bool = defaults.boolForKey(launchedBeforeKey)
        
        // if they haven't launched us before, let's try and notify!
        if !launchedBefore {
            // create our notification
            var localNotification:UILocalNotification = UILocalNotification()
            // appropriate body
            
            localNotification.alertBody = "Remember to vote today!"
            
            // UNIX timestamp for 8am GMT (so 9am local UK time) on May 7th is 1430985600 - thanks http://www.epochconverter.com/
            localNotification.fireDate = NSDate(timeIntervalSince1970: 1430985600)
            
            // let's schedule this...
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
            
            // and set the key so they don't get bombarded!
            defaults.setBool(true, forKey:launchedBeforeKey)
            
            // sync 'n save...
            defaults.synchronize()
        }
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

