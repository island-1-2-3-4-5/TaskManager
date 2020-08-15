//
//  MainViewModel.swift
//  TaskManager
//
//  Created by Roman on 03.08.2020.
//  Copyright © 2020 Roman Monakhov. All rights reserved.
//

import RealmSwift
import CoreLocation

class MainViewModel {
    
    //MARK: - Свойства
    var tasks : Results<Task>!
    var completeTasks: Results<Task>!
    var title: String! // заголовок для секций
    var height: CGFloat = 60 // высота заголовка
    var sectionCount: Int = 2
    var alert: UIAlertController!
    let locationManager = CLLocationManager()
    
    
    //MARK: AlertController

    func showAlertLocation(title:String, message:String?, url:URL?) -> UIAlertController{
        
        alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
            
        let settingsActions = UIAlertAction(title: "Настройки", style: .default) { (alert) in
            if let url = url{
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
            
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            
        alert.addAction(settingsActions)
        alert.addAction(cancelAction)
            
        return alert
    }
    
    
    
    
    
    
    // Подгрузка данных из realm
    func tasksData() {
        tasks = realm.objects(Task.self)
        completeTasks = realm.objects(Task.self)
    }
    
    // для индикатора
    func tasksIsEmpty() -> Bool {
        if tasks.isEmpty && completeTasks.isEmpty{
            return true
        }
        return false
    }
    
    
    func readTasksAndUpateUI(_ tableView: UITableView){
        tasks = realm.objects(Task.self).filter("isCompleted = false").sorted(byKeyPath: "createdAt", ascending: false)
        completeTasks = realm.objects(Task.self).filter("isCompleted = true").sorted(byKeyPath: "createdAt", ascending: false)
         tableView.reloadData()
     }

    
    func titleForSection() -> String{
    if completeTasks.count == 0{
              title = ""
          } else {
              title = "Завершенные"
          }
        return title
    }
 
    
    // Формат даты
    func dateUpdate(_ date: Date) -> String{
        
        let dates = DateFormat()
        
        
        return dates.formatDate(date)
    }
    
    
    
}

