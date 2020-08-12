//
//  MainViewModel.swift
//  TaskManager
//
//  Created by Roman on 03.08.2020.
//  Copyright © 2020 Roman Monakhov. All rights reserved.
//

import RealmSwift

class MainViewModel {
    
    //MARK: - Свойства
    var tasks : Results<Task>!
    var completeTasks: Results<Task>!
    var title: String! // заголовок для секций
    var height: CGFloat = 60 // высота заголовка
    var sectionCount: Int = 2
    var location = TaskUserLocations()
    
    
    
    
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
        tasks = realm.objects(Task.self).filter("isCompleted = false")
        completeTasks = realm.objects(Task.self).filter("isCompleted = true")
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

