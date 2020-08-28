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
    var allTasks : Results<Task>!
    var expiredTasks : Results<Task>!
    var tasks : Results<Task>!
    var tomorrowTasks : Results<Task>!
    var afterTomorrowTasks : Results<Task>!
    var otherTasks : Results<Task>!
    var completeTasks: Results<Task>!
    
    var title: String! // заголовок для секций
    var height: CGFloat = 60 // высота заголовка
    var sectionCount: Int = 7
    var alert: UIAlertController!
    let locationManager = CLLocationManager()
    let settingsViewModel = SettingViewModel()
    var h = 0
    var m = 0

    
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
    

    //MARK: Подгрузка данных из realm
    func tasksData() {
        allTasks = realm.objects(Task.self)
        tasks = realm.objects(Task.self)
        completeTasks = realm.objects(Task.self)
        expiredTasks = realm.objects(Task.self)
        tomorrowTasks = realm.objects(Task.self)
        afterTomorrowTasks = realm.objects(Task.self)
        otherTasks = realm.objects(Task.self)
    }
    
    // для индикатора
    func tasksIsEmpty() -> Bool {
        if allTasks.isEmpty {
            return true
        }
        return false
    }
    
    
//MARK: Обновление интерфейса
    // эта функция вызывается раз в секунду в MainViewController
    func updateUI(_ tableView: UITableView) {

        let date = Date()

        for i in 0..<allTasks.count{
                    
            let count = tasks.count
            let task = allTasks[i]
            try! realm.write{
                            
                let pickerDate = formatPickerDate(task.pickerDate!, 0, 0)

                let dates = formatPickerDate(task.date, 0, 0)
                
                let day = pickerDate.day! - dates.day!
                
                if day == 0 {
                    task.whatsDay = "сегодня"
                } else if day == 1 {
                    task.whatsDay = "завтра"
                } else if day == 2 {
                    task.whatsDay = "послезавтра"
                } else {
                    task.whatsDay = "В другие дни"
                }
                
                task.date = date
                if tasks.count != count{
                    settingsViewModel.notification()
                    tableView.reloadData()
                        
                }
                    
            }
                    
        }
        
    }
    
    
    
    func notification(){
        settingsViewModel.notification()
      
        h = settingsViewModel.h
        m = settingsViewModel.m
    }
    
    
    //MARK: Фильтрация массивов
     func readTasksAndUpateUI(_ tableView: UITableView){

    
        tasks = realm.objects(Task.self).filter("isCompleted = false AND pickerDate > date AND whatsDay =  %@", "сегодня").sorted(byKeyPath: "pickerDate", ascending: true)
    
        tomorrowTasks = realm.objects(Task.self).filter("isCompleted = false AND pickerDate > date AND whatsDay =  %@", "завтра").sorted(byKeyPath: "pickerDate", ascending: true)
        
        afterTomorrowTasks = realm.objects(Task.self).filter("isCompleted = false AND pickerDate > date AND whatsDay =  %@", "послезавтра").sorted(byKeyPath: "pickerDate", ascending: true)
        
        otherTasks = realm.objects(Task.self).filter("isCompleted = false AND pickerDate > date AND whatsDay =  %@", "В другие дни").sorted(byKeyPath: "pickerDate", ascending: true)
          
        completeTasks = realm.objects(Task.self).filter("isCompleted = true").sorted(byKeyPath: "pickerDate", ascending: true)
        
        expiredTasks = realm.objects(Task.self).filter("isCompleted = false AND pickerDate < date").sorted(byKeyPath: "pickerDate", ascending: true)
            
 
        tableView.reloadData()

     }

    
    
    //MARK: Заголовок устаревшие
    func titleForExpiredSection() -> String{
       if expiredTasks.count == 0{
                 title = ""
             } else {
                 title = "Просроченные"
             }
           return title
       }

    //MARK: Заголовок предстоящие
    func titleForComingSection() -> String{
        if (tasks.count == 0) && (tomorrowTasks.count == 0) && (afterTomorrowTasks.count == 0) && (otherTasks.count == 0){
                 title = ""
             } else {
                 title = "Предстоящие"
             }
           return title
       }
    //MARK: Заголовок сегодня
    func titleForTodaySection() -> String{
       if tasks.count == 0{
                 title = ""
             } else {
        let date = Date()
        let dates = formatPickerDate(date, 0, 0)
        title = "Сегодня, \(dates.day!) \(month(dates.month!))"
             }
           return title
       }
    //MARK: Заголовок завтра
    func titleForTomorrowSection() -> String{
       if tomorrowTasks.count == 0{
                 title = ""
             } else {
        let date = Date()
        let dates = formatPickerDate(date, 0, 0)
        let day = dates.day! + 1
      
        title = "Завтра, \(day) \(month(dates.month!))"
             }
           return title
       }
    //MARK: Заголовок послезавтра
    func titleAfterTomorrowSection() -> String{
       if afterTomorrowTasks.count == 0{
                 title = ""
             } else {
        let date = Date()
        let dates = formatPickerDate(date, 0, 0)
        let day = dates.day! + 2
        title = "Послезавтра, \(day) \(month(dates.month!))"
             }
           return title
       }
    //MARK: Заголовок остальные
    func titleOtherSection() -> String{
       if otherTasks.count == 0{
                 title = ""
             } else {
                 title = "В другие дни"
             }
           return title
       }
    
    //MARK: Заголовок завершенные
    func titleForSection() -> String{
    if completeTasks.count == 0{
              title = ""
          } else {
              title = "Завершенные"
          }
        return title
    }
    
    
    //MARK: Конвертация месяца
    func month(_ month: Int) -> String {
        if month == 1{
            return "января"
        } else if month == 2{
            return "февраля"
        } else if month == 3{
            return "марта"
        } else if month == 4{
            return "апреля"
        } else if month == 5{
            return "мая"
        } else if month == 6{
            return "июня"
        } else if month == 7{
            return "июля"
        } else if month == 8{
            return "августа"
        } else if month == 9{
            return "сентября"
        } else if month == 10{
            return "октября"
        } else if month == 11{
            return "ноября"
        } else if month == 12{
            return "декабря"
        }
        return ""
    }
 
    
    //MARK: Формат даты
    func dateInHourUpdate(_ date: Date) -> String{
        
        let dates = DateFormat()
        
        return dates.formatDateInHour(date)
    }
    
    func dateUpdate(_ date: Date) -> String{
        let dates = DateFormat()
        return dates.formatDate(date)
    }

    
    func formatPickerDate(_ pickerDate: Date, _ h: Int, _ m: Int) -> DateComponents{
        let dates = DateFormat()
        
       return dates.formatPickerDate(pickerDate, h, m)
    }
    
    
}

