//
//  ViewController.swift
//  Notifications
//
//  Created by Jakub Slawecki on 23.02.2018.
//  Copyright © 2018 Jakub Slawecki. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
                            // 1. Request Permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
            
            if granted {
                print ("Notification access granted")
            } else {
                print (error?.localizedDescription)
            }
        })
    }
    
    
    @IBAction func notifyButtonPressed(_ sender: UIButton) {
        
        scheduleNotification(inSeconds: 7, completion: { success in
            if success {
                print("Successfully scheduled notification")
            } else {
                print("Error scheduling nitification")
            }
        })
    }
    
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        // Add an attachment
        let myImage = "selfie1"
        guard let imageURL = Bundle.main.url(forResource: myImage, withExtension: "jpg") else {
            completion(false)
            return
        }
        
        var attachment: UNNotificationAttachment
        
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageURL, options: .none)
        
        let notif = UNMutableNotificationContent()
        
        // Only for extension
        notif.categoryIdentifier = "myNotificationCategory"
        
        notif.title = "New Notification"
        notif.subtitle = "Who's the prettiest of them all?” "
        notif.body = "  Of course you Jake!"
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






















