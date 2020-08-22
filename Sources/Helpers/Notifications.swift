//
//  Notifications.swift
//  TaskManager
//
//  Created by Roman on 22.08.2020.
//  Copyright © 2020 Roman Monakhov. All rights reserved.
//

import UIKit
import UserNotifications

class Notifications: NSObject, UNUserNotificationCenterDelegate {
  
    
    let notificationCenter = UNUserNotificationCenter.current()

    func requestAutorization() {
         notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
             print("Permission granted: \(granted)")
             
             guard granted else { return }
             self.getNotificationSettings()
         }
     }
     
     func getNotificationSettings() {
         notificationCenter.getNotificationSettings { (settings) in
             print("Notification settings: \(settings)")
         }
     }
     
    func scheduleNotification(notifaicationType: String, date: Date, h: Int, m: Int) {
         
         let content = UNMutableNotificationContent()
         content.title = notifaicationType
         content.body = notifaicationType
         content.sound = UNNotificationSound.default
         content.badge = 1
         var dateComponent = DateComponents()
         let calendar = Calendar.current
         let hour = calendar.component(.hour, from: date) - h
         let minute = calendar.component(.minute, from: date) - m
         dateComponent.hour = hour
         dateComponent.minute = minute
         
        // для этого триггера устанавливаем дату срабатывания, она приходит из функции notification
         let anotherTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
         
         let identifire = "Local Notification"
         let request = UNNotificationRequest(identifier: identifire,
                                             content: content,
                                             trigger: anotherTrigger)
         
         notificationCenter.add(request) { (error) in
             if let error = error {
                 print("Error \(error.localizedDescription)")
             }
         }
     }

    
    
    
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.notification.request.identifier == "Local Notification" {
            print("Handling notification with the Local Notification Identifire")
        }
        
        completionHandler()
    }

}
