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
        
        //Actions
        let remindLaterAction = UNNotificationAction(identifier: "remindLater", title: "Remind me later", options: UNNotificationActionOptions(rawValue: 0))
        let acceptAction = UNNotificationAction(identifier: "accept", title: "Accept", options: .foreground)
        let declineAction = UNNotificationAction(identifier: "decline", title: "Decline", options: .destructive)
        let commentAction = UNTextInputNotificationAction(identifier: "comment", title: "Comment", options: .authenticationRequired, textInputButtonTitle: "Send", textInputPlaceholder: "Share your thoughts..")
        
        
        // #1.1 - Create "the notification's category value--its type."
        let debitOverdraftNotifCategory = UNNotificationCategory(identifier: "debitOverdraftNotification", actions: [remindLaterAction, acceptAction], intentIdentifiers: [], options: UNNotificationCategoryOptions(rawValue: 0))
        // #1.2 - Register the notification type.
        notificationCenter.setNotificationCategories([debitOverdraftNotifCategory])
        print("do we support customization? \(notificationCenter.supportsContentExtensions)")
        notificationCenter.delegate = self
        
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void)
    {
        switch response.notification.request.content.categoryIdentifier
        {
        case "GENERAL":
            break
            
        case "debitOverdraftNotification":
            switch response.actionIdentifier
            {
            case "remindLater":
                print("remindLater")
                
            case "accept":
                print("accept")
                
            default:
                break
            }
            
        default:
            break
        }
        completionHandler()
    }
    
    //Here you decide whether to silently handle the notification or still alert the user.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        //Write you app specific code here
        completionHandler([.alert, .sound]) //execute the provided completion handler block with the delivery option (if any) that you want the system to use. If you do not specify any options, the system silences the notification.
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
        content.categoryIdentifier = "debitOverdraftNotification"
        content.userInfo = ["items":["apple", "hot cross bun", "chips"]]
        
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

