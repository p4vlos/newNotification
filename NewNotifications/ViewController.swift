//
//  ViewController.swift
//  NewNotifications
//
//  Created by Pavlos Nicolaou on 15/09/2016.
//  Copyright © 2016 Pavlos Nicolaou. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. REQUESST PERMISSION
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
         
            if granted {
                print("Notification access granted")
            } else {
                print(error?.localizedDescription)
            }
        })
        
    }
    
    @IBAction func notifyButtonTapped(sender: UIButton) {
        
        scheduleNotification(inSeconds: 5) { (success) in
            
            if success {
                print("Successfully scheduled notification")
            } else {
                print("Error scheduling notification")
            }
        }
    }

    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping ( _ Success: Bool) -> ()) {
        
        //Add an attachment
        let myImage = "IMG"
        guard let imageUrl = Bundle.main.url(forResource: myImage, withExtension: "jpeg") else {
            completion(false)
            return
        }
        
        var attachment: UNNotificationAttachment
        
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageUrl, options: .none)
        
        let notif = UNMutableNotificationContent()
        
        notif.title = "New Notification"
        notif.subtitle = "Those are great!"
        notif.body = "The new notification option in iOS 10 are what I've always dreamed of"
        
        notif.attachments = [attachment]
        
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print(error)
                completion(false)
            } else {
                
                completion(true)
            }
        })
    }
}
