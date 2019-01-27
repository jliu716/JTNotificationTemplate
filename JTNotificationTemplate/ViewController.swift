//
//  ViewController.swift
//  JTNotificationTemplate
//
//  Created by Beethoven on 28/01/19.
//  Copyright © 2019 Jiayi Liu. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    let button : UIButton = UIButton.init(frame: CGRect.zero)
    let notificationCenter : UNUserNotificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupButton()
    }
    
    func setupButton(){
        // draw a button take up the whole middle space
        let height = UIScreen.main.bounds.size.height / 3.0
        let width  = UIScreen.main.bounds.size.width
        let x = CGFloat(0)
        let y = UIScreen.main.bounds.size.height / 3.0
        let frame : CGRect = CGRect(x: x, y: y, width: width, height: height)
        
        button.frame = frame
        button.backgroundColor = UIColor.groupTableViewBackground
        button.setTitle("PRESS ME", for: UIControl.State.normal)
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button.setTitleColor(UIColor.gray, for: UIControl.State.highlighted)
        
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(checkPermission), for: UIControl.Event.touchUpInside)
        
    }
    
    @objc func checkPermission(){
        notificationCenter.getNotificationSettings { (settings) in
            if(settings.authorizationStatus != .authorized){
                self.requestPermission()
            }else{
                self.fireTestNotification()
            }
        }
    }
    
    func requestPermission(){
        // define what do you need permission to use
        let options: UNAuthorizationOptions = [.alert, .sound]
        
        // request permission
        notificationCenter.requestAuthorization(options: options) { (granted, error) in
            if !granted {
                print("Permission not granted")
            }
        }
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

