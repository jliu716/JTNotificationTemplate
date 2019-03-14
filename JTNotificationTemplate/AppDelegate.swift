//
//  AppDelegate.swift
//  JTNotificationTemplate
//
//  Created by Beethoven on 28/01/19.
//  Copyright © 2019 Jiayi Liu. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    let notificationCenter : UNUserNotificationCenter = UNUserNotificationCenter.current()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        notificationCenter.delegate = self
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
        fireTestNotification()
        
    }

    func fireTestNotification(){
        // create notification
        let content = UNMutableNotificationContent()
        content.title = "Title Here"
        content.body = "Body Here"
        content.sound = UNNotificationSound.default
        
        // after user enters, how long to trigger the notification
        let timeInSeconds : TimeInterval = 5
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInSeconds,
                                                        repeats: false)
        
        // send notification request
        let request = UNNotificationRequest(identifier: "joytest",
                                            content: content,
                                            trigger: trigger)
        
        // trying to add the notification request to notification center
        notificationCenter.add(request, withCompletionHandler: { (error) in
            if error != nil {
                print("Error adding notification with identifier : joytest")
            }
        })
    }

}

