//
//  SettingsViewModel.swift
//  TaskManager
//
//  Created by Roman on 26.08.2020.
//  Copyright © 2020 Roman Monakhov. All rights reserved.
//


import UIKit
import RealmSwift

class SettingViewModel {
    let notifications = Notifications()

    var tasks: Results<Task>!
    var settings: Results<Settings>!

    var h = 0
    var m = 0
        
    
    func dataLoad(){
        settings = realm.objects(Settings.self)
        tasks = realm.objects(Task.self)
    }
    
    func updateUI() {
        tasks = realm.objects(Task.self)
        settings = realm.objects(Settings.self)
         tasks = realm.objects(Task.self).filter("isCompleted = false AND pickerDate > date AND whatsDay =  %@", "сегодня").sorted(byKeyPath: "pickerDate", ascending: true)
    }
    
    //MARK: Запись
    func saveSettings(){
        let newSettings = Settings(numberSwitchIsOn: 2, remindersIsOn: false, securityIsOn: false, faceIdIsOn: false, touchIdIsOn: false)

        
        if settings.count == 0 {
            // сохраняем новый объект в базе
            StorageManager.saveSettings(newSettings)

        }
    }
    
    
    
    // эта функция вызывается когда мы включаем пререключатель для уведомлений
//MARK: Уведомления
    func notification(){
        updateUI()

        guard settings.count != 0 else { return }
        
        // outlet переключателя уведомлений
        if settings[0].remindersIsOn{
            // массив с записями из realm
            
            
        guard tasks.count != 0 else { return }
            
            
        // перебираю записи начиная с самой ранней
        for i in 0..<tasks.count{

            alarmFormat()
            
            let task = tasks[i]

            let identifire = String(describing: task.createdAt)
            
            guard let date = task.pickerDate else {return}

            // отправка даты для срабатывания уведомления
            notifications.scheduleNotification(identifire: identifire, date: date, h: h, m: m)
            
            }
            
        }
        
    }
    
    
    
    //MARK: За сколько оповещать
    func alarmFormat(){
        if settings[0].numberSwitchIsOn == 0{
            h = 0
            m = 15
        } else if settings[0].numberSwitchIsOn == 1{
            h = 0
            m = 30
        } else if settings[0].numberSwitchIsOn == 2{
            h = 1
            m = 0
        } else if settings[0].numberSwitchIsOn == 3{
            h = 2
            m = 0
        } else if settings[0].numberSwitchIsOn == 4{
            h = 8
            m = 0
        } else if settings[0].numberSwitchIsOn == 5{
            h = 12
            m = 0
        } else if settings[0].numberSwitchIsOn == 6{
            h = 24
            m = 0
        }
    }
}

