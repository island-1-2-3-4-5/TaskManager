//
//  StorageManager.swift
//  TaskManager
//
//  Created by Roman on 02.08.2020.
//  Copyright © 2020 Roman Monakhov. All rights reserved.
//

import RealmSwift

let realm = try! Realm()


// тут мы либо сохранияем либо удаляем из базы объекты
class StorageManager {
    
    // необходимо лишь вызвать этот метод
    static func saveObject(_ task: Task){
        
        try! realm.write{
            realm.add(task)
        }
    }
    
    static func deleteObject(_ task: Task) {
        try! realm.write {
            realm.delete(task)
        }
    }
    
    
    
    //MARK: Для экрана с настройками
    // необходимо лишь вызвать этот метод
    static func saveSettings(_ settings: Settings){
        
        try! realm.write{
            realm.add(settings)
        }
    }
    
    static func deleteSettings(_ settings: Settings) {
        try! realm.write {
            realm.delete(settings)
        }
    }
    
}
