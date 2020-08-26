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
    let notifications = Notifications()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let schemaVersion: UInt64 = 26

              
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
                notifications.requestAutorization()
                notifications.notificationCenter.delegate = notifications
        
        
        return true
    }
 

    
    
 
}






