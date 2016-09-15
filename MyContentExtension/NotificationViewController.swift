//
//  NotificationViewController.swift
//  MyContentExtension
//
//  Created by Pavlos Nicolaou on 15/09/2016.
//  Copyright © 2016 Pavlos Nicolaou. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
   
        guard let attachment = notification.request.content.attachments.first else {
            
            return
        }
        
        if attachment.url.startAccessingSecurityScopedResource() {
            
            let imageData = try? Data.init(contentsOf: attachment.url)
            if let img = imageData{
                imageView.image = UIImage(data: img)
            }
        }
    }
    
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        
        if response.actionIdentifier == "fistBump" {
            completion(.dismissAndForwardAction)
        } else if response.actionIdentifier == "dismiss" {
            completion(.dismissAndForwardAction)
        }
    }

}
