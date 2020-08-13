//
//  DetailViewModel.swift
//  TaskManager
//
//  Created by Roman on 03.08.2020.
//  Copyright © 2020 Roman Monakhov. All rights reserved.
//

import RealmSwift
import MapKit

class DetailViewModel{
    
    var currentTask: Task!
    
    func annotation() -> MKPointAnnotation{
    let annotation = MKPointAnnotation()
    annotation.coordinate.latitude = currentTask.latitude
    annotation.coordinate.longitude = currentTask.longitude
        return annotation
    }
    
    func dateUpdate() -> String{
        let date = currentTask.createdAt!
        let dates = DateFormat()
        return dates.formatDate(date)
    }
    
    
    func descriptionUpdate() -> String{
        return currentTask.descriptionTask!
    }
             

    func nameUpdate() -> String{
        return currentTask.name
     }
    
    
    func completeTask(){
        try! realm.write{
                  currentTask.isCompleted = true
              }
    }
    
    func deleteTask() {
           StorageManager.deleteObject(currentTask)
       }
    
}
