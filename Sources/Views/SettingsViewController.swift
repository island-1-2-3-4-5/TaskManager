//
//  SettingsViewController.swift
//  TaskManager
//
//  Created by Roman on 15.08.2020.
//  Copyright © 2020 Roman Monakhov. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

class SettingsViewController: UIViewController {

    //MARK: Свойства
    var settingsViewModel = SettingViewModel()


   
    
    //MARK: Outlets
    @IBOutlet weak var remindersStack: UIStackView!
    @IBOutlet weak var passwordStack: UIStackView!
    @IBOutlet weak var faceIdStack: UIStackView!
    @IBOutlet weak var touchIdersStack: UIStackView!
    @IBOutlet weak var reminderSwitchOutlet: UISwitch!
    @IBOutlet var timeSwitches: [UISwitch]!
    @IBOutlet weak var faceIDSwitch: UISwitch!
    @IBOutlet weak var touchIDSwitch: UISwitch!
    @IBOutlet weak var securitySwitch: UISwitch!
    
    
    
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsViewModel.dataLoad()

        setUpScreen()

        }
    
    
    //MARK: Отображение
    func setUpScreen(){
        
        settingsViewModel.saveSettings()
        setupNavigationBar()
        
        reminderSwitchOutlet.isOn = settingsViewModel.settings[0].remindersIsOn
        
        securitySwitch.isOn = settingsViewModel.settings[0].securityIsOn
        
        
        if reminderSwitchOutlet.isOn{ remindersStack.isHidden = false }
        if securitySwitch.isOn{
            passwordStack.isHidden = false
            faceIdStack.isHidden = false
            touchIdersStack.isHidden = false
            faceIDSwitch.isOn = settingsViewModel.settings[0].faceIdIsOn
            touchIDSwitch.isOn = settingsViewModel.settings[0].touchIdIsOn
            
        }
        
        switch settingsViewModel.settings[0].numberSwitchIsOn{
        case 0:
            timeSwitches[0].isOn = true
        case 1:
            timeSwitches[1].isOn = true
        case 2:
            timeSwitches[2].isOn = true
        case 3:
            timeSwitches[3].isOn = true
        case 4:
            timeSwitches[4].isOn = true
        case 5:
            timeSwitches[5].isOn = true
        case 6:
            timeSwitches[6].isOn = true
        default:
            break
        }
  

    }
    

    
    //MARK: Перезапись
    func reSaveRemindersSettings(_ numberSwitch:Int){
            try! realm.write{
                settingsViewModel.settings[0].numberSwitchIsOn = numberSwitch
                settingsViewModel.settings[0].remindersIsOn = reminderSwitchOutlet.isOn
            }

    }
    
    
    
    
    //MARK: - Actions
    
    
    
    // MARK: Установка напоминаний
    @IBAction func remindersSwitch(_ sender: UISwitch) {

        if sender.isOn == false{
            reminderSwitchOutlet.isOn = false
            remindersStack.isHidden = true

            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        } else {
            reminderSwitchOutlet.isOn = true
            remindersStack.isHidden = false
            settingsViewModel.notification()
                }
        
        reSaveRemindersSettings(settingsViewModel.settings[0].numberSwitchIsOn)

            }
            

    
    //MARK: 15 минут
    @IBAction func fiftyMinutesSwitch(_ sender: UISwitch) {
        if sender.isOn{
            turnOffSwitch()
            timeSwitches[0].isOn = true
            reSaveRemindersSettings(0)
            
        }
    }
    //MARK: 30 минут

    @IBAction func thirtyMinutesSwitch(_ sender: UISwitch) {
        if sender.isOn{
            turnOffSwitch()
            timeSwitches[1].isOn = true
            reSaveRemindersSettings(1)
        }
    }
    
    //MARK: 1 час

    @IBAction func oneHourSwitch(_ sender: UISwitch) {
        if sender.isOn{
            turnOffSwitch()
            timeSwitches[2].isOn = true
            reSaveRemindersSettings(2)
        }
    }
    
    //MARK: 2 часа

    @IBAction func twoHourSwitch(_ sender: UISwitch) {
        if sender.isOn{
            turnOffSwitch()
            timeSwitches[3].isOn = true
            reSaveRemindersSettings(3)
        }
    }
    
    //MARK: 8 часов

    @IBAction func eightHourSwitch(_ sender: UISwitch) {
        if sender.isOn{
            turnOffSwitch()
            timeSwitches[4].isOn = true
            reSaveRemindersSettings(4)
        }
    }
    
    //MARK: 12 часов

    @IBAction func twelveHourSwitch(_ sender: UISwitch) {
        if sender.isOn{
            turnOffSwitch()
            timeSwitches[5].isOn = true
            reSaveRemindersSettings(5)
        }
    }
    
    //MARK: 1 день

    @IBAction func oneDaySwitch(_ sender: UISwitch) {
        if sender.isOn{
            turnOffSwitch()
            timeSwitches[6].isOn = true
            reSaveRemindersSettings(6)
        }
    }
    
    //MARK: Выключение переключателей
    func turnOffSwitch(){
        timeSwitches[0].isOn = false
        timeSwitches[1].isOn = false
        timeSwitches[2].isOn = false
        timeSwitches[3].isOn = false
        timeSwitches[4].isOn = false
        timeSwitches[5].isOn = false
        timeSwitches[6].isOn = false
    }
    
    
    //MARK: Запрос пароля
    @IBAction func securityActionSwitch(_ sender: UISwitch) {
        if sender.isOn == false{
            passwordStack.isHidden = true
            faceIdStack.isHidden = true
            touchIdersStack.isHidden = true
            faceIDSwitch.isOn = false
            touchIDSwitch.isOn = false
        } else {
            passwordStack.isHidden = false
            faceIdStack.isHidden = false
            touchIdersStack.isHidden = false
            faceIDSwitch.isOn = settingsViewModel.settings[0].faceIdIsOn
            touchIDSwitch.isOn = settingsViewModel.settings[0].touchIdIsOn
        }
        reSaveSecuritySettings()
    }
    
    
    @IBAction func faceIDActionSwitch(_ sender: UISwitch) {
        if sender.isOn{
            faceIDSwitch.isOn = true
        } else {
            faceIDSwitch.isOn = false
        }
        reSaveSecuritySettings()
    }
    
    
    @IBAction func touchIDActionSwitch(_ sender: UISwitch) {
        if sender.isOn{
            touchIDSwitch.isOn = true
        } else {
            touchIDSwitch.isOn = false
        }
        reSaveSecuritySettings()

    }
    
    
    
    
    func reSaveSecuritySettings(){
        try! realm.write{
        settingsViewModel.settings[0].securityIsOn = securitySwitch.isOn
        settingsViewModel.settings[0].faceIdIsOn = faceIDSwitch.isOn
        settingsViewModel.settings[0].touchIdIsOn = touchIDSwitch.isOn
        }
    }
    
    
    // MARK: - Навигация назад Main
    private func setupNavigationBar() {
        // если существует Item в навигационном баре, то можно там что-то изменить
        if let topItem = navigationController?.navigationBar.topItem {
            // меняем наименование кнопки возврата
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            topItem.backBarButtonItem?.tintColor = .black
            
        }
         
        navigationItem.leftBarButtonItem = nil // убираем кнопку cancel, чтобы вместо неё была кнопка back
         
    }
    
    
    
    
    
    
    
    
    
    @IBAction func unwindPassword(_ segue: UIStoryboardSegue) {
        // передаем новое значение в таблицу
        guard let newPasswordVC = segue.source as? PasswordViewController else {return}
        newPasswordVC.savePassword()

       }


}
