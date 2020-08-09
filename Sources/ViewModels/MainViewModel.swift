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
    
    
    
    
    func tasksData() {
        tasks = realm.objects(Task.self)
        completeTasks = realm.objects(Task.self)
    }
    
    
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

    
    
 
}

