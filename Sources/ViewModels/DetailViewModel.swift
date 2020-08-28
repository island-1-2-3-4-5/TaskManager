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
    let settingsViewModel = SettingViewModel()

    
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
    
    func pickerDate() -> String{
        let date = currentTask.pickerDate!
        let dates = DateFormat()
        return dates.formatDate(date)
     }
    
    
    
    
    func textColorDate() -> UIColor{
        if currentTask.pickerDate! < currentTask.date && currentTask.isCompleted == false {
            return UIColor(rgb: 0xEB5757)
        } else if currentTask.pickerDate! > currentTask.date && currentTask.isCompleted == false {
            
            let formatPickerDate = DateFormat()
            settingsViewModel.notification()
            
            let pickerDate = Calendar.current.date(from:             formatPickerDate.formatPickerDate(currentTask.pickerDate!,settingsViewModel.h , settingsViewModel.m))!

            let date = Calendar.current.date(from:             formatPickerDate.formatPickerDate(currentTask.date,0 , 0))!
            
            
            if date < pickerDate {
                return UIColor(rgb: 0x219653)
            } else {
               return UIColor(rgb: 0xF2994A)
            }
            
            
            
        }
      return UIColor(rgb: 0xBDBDBD)

        
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
