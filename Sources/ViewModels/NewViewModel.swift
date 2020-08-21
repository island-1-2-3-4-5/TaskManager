//
//  NewViewModel.swift
//  TaskManager
//
//  Created by Roman on 09.08.2020.
//  Copyright © 2020 Roman Monakhov. All rights reserved.
//
import UIKit
import CoreLocation
class NewViewModel{
    var currentTask: Task! // это свойство содержит информацию о текущей выбранной ячейке
    let date = Date()
    var editTrigger: Bool!
    let locationManager = CLLocationManager()
    // Эти значения приходят из расширения в файле TaskUserLocations
    var latitude: Double?
    var longitude: Double?
    
    
    func descriptionUpdate() -> String{
        return currentTask.descriptionTask!
    }
             

    func nameUpdate() -> String{
        return currentTask.name
     }
    
  func pickerDateUpdate() -> Date{
    return currentTask.pickerDate!
    }
    
    func locationsSettings(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
}
