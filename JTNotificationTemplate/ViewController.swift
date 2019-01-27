//
//  ViewController.swift
//  JTNotificationTemplate
//
//  Created by Beethoven on 28/01/19.
//  Copyright © 2019 Jiayi Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let button : UIButton = UIButton.init(frame: CGRect.zero)
    
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

    }
    
}

