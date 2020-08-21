//
//  AppDelegate.swift
//  TaskManager
//
//  Created by Roman on 30.07.2020.
//  Copyright © 2020 Roman Monakhov. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let notificationCenter = UNUserNotificationCenter.current()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let schemaVersion: UInt64 = 24

              
              // добавляем это для того, чтобы можно было изменять модель данных без удаления самих данных
              
              let config = Realm.Configuration(
                  // Set the new schema version. This must be greater than the previously used
                  // version (if you've never set a schema version before, the version is 0).
                  schemaVersion: schemaVersion,

                  // Set the block which will be called automatically when opening a Realm with
                  // a schema version lower than the one set above
                  migrationBlock: { migration, oldSchemaVersion in
                      // We haven’t migrated anything yet, so oldSchemaVersion == 0
                      if (oldSchemaVersion < schemaVersion) {
                          // Nothing to do!
                          // Realm will automatically detect new properties and removed properties
                          // And will update the schema on disk automatically
                      }
                  })

              // Tell Realm to use this new configuration object for the default Realm
              Realm.Configuration.defaultConfiguration = config
        
        
        
        
                //MARK: - Уведомления
        requestAutorization()
        notificationCenter.delegate = self
        
        
        return true
    }


    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    
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
    
    func scheduleNotification(notifaicationType: String) {
        
        let content = UNMutableNotificationContent()
        
        content.title = notifaicationType
        content.body = notifaicationType
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let identifire = "Local Notification"
        let request = UNNotificationRequest(identifier: identifire,
                                            content: content,
                                            trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
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


