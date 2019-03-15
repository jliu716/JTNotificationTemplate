//
//  NotificationViewController.swift
//  JLAlertContentExtension
//
//  Created by Beethoven on 14/03/19.
//  Copyright © 2019 Jiayi Liu. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension, UITableViewDelegate, UITableViewDataSource {

    var data : [String] = []

    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("something happened!")
        tableView.dataSource = self
        tableView.delegate = self
        let size = view.bounds.size
        preferredContentSize = CGSize(width: size.width, height: size.height / 4.0)
    }
    
    func didReceive(_ notification: UNNotification) {
        let info = notification.request.content.userInfo
        data = info["items"] as! [String]
        print(data)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let x : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        x.textLabel?.text = data[indexPath.row]
        
        return x
    }

}
