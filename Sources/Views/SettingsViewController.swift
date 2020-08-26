//
//  SettingsViewController.swift
//  TaskManager
//
//  Created by Roman on 15.08.2020.
//  Copyright © 2020 Roman Monakhov. All rights reserved.
//

import UIKit
import RealmSwift

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
        
        if reminderSwitchOutlet.isOn{ remindersStack.isHidden = false }
        
        
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
    func reSaveSettings(_ numberSwitch:Int){
            try! realm.write{
                settingsViewModel.settings[0].numberSwitchIsOn = numberSwitch
                settingsViewModel.settings[0].remindersIsOn = reminderSwitchOutlet.isOn
            }

    }
    
    
    
    
    //MARK: - Actions
    
    // MARK: Установка напоминаний
    @IBAction func remindersSwitch(_ sender: UISwitch) {

        reSaveSettings(settingsViewModel.settings[0].numberSwitchIsOn)
        
        if sender.isOn == false{
            reminderSwitchOutlet.isOn = false
            remindersStack.isHidden = true
        } else {
            reminderSwitchOutlet.isOn = true
            remindersStack.isHidden = false
            settingsViewModel.notification()
                }
            }
            

    //MARK: Запрос пароля
    @IBAction func passwordSwitch(_ sender: UISwitch) {
        if sender.isOn == false{
            passwordStack.isHidden = true
            faceIdStack.isHidden = true
            touchIdersStack.isHidden = true
        } else {
            passwordStack.isHidden = false
            faceIdStack.isHidden = false
            touchIdersStack.isHidden = false
        }
    }

    
    //MARK: 15 минут
    @IBAction func fiftyMinutesSwitch(_ sender: UISwitch) {
        if sender.isOn{
            turnOffSwitch()
            timeSwitches[0].isOn = true
            reSaveSettings(0)
            
        }
    }
    //MARK: 30 минут

    @IBAction func thirtyMinutesSwitch(_ sender: UISwitch) {
        if sender.isOn{
            turnOffSwitch()
            timeSwitches[1].isOn = true
            reSaveSettings(1)
        }
    }
    
    //MARK: 1 час

    @IBAction func oneHourSwitch(_ sender: UISwitch) {
        if sender.isOn{
            turnOffSwitch()
            timeSwitches[2].isOn = true
            reSaveSettings(2)
        }
    }
    
    //MARK: 2 часа

    @IBAction func twoHourSwitch(_ sender: UISwitch) {
        if sender.isOn{
            turnOffSwitch()
            timeSwitches[3].isOn = true
            reSaveSettings(3)
        }
    }
    
    //MARK: 8 часов

    @IBAction func eightHourSwitch(_ sender: UISwitch) {
        if sender.isOn{
            turnOffSwitch()
            timeSwitches[4].isOn = true
            reSaveSettings(4)
        }
    }
    
    //MARK: 12 часов

    @IBAction func twelveHourSwitch(_ sender: UISwitch) {
        if sender.isOn{
            turnOffSwitch()
            timeSwitches[5].isOn = true
            reSaveSettings(5)
        }
    }
    
    //MARK: 1 день

    @IBAction func oneDaySwitch(_ sender: UISwitch) {
        if sender.isOn{
            turnOffSwitch()
            timeSwitches[6].isOn = true
            reSaveSettings(6)
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

}
