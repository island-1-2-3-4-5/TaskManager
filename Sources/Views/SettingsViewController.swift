//
//  SettingsViewController.swift
//  TaskManager
//
//  Created by Roman on 15.08.2020.
//  Copyright © 2020 Roman Monakhov. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var remindersStack: UIStackView!
    @IBOutlet weak var passwordStack: UIStackView!
    @IBOutlet weak var faceIdStack: UIStackView!
    @IBOutlet weak var touchIdersStack: UIStackView!

    @IBOutlet var timeSwitches: [UISwitch]!
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        setupNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    
    //MARK: - Actions
    @IBAction func remindersSwitch(_ sender: UISwitch) {

        if sender.isOn == false{
            remindersStack.isHidden = true
            
        } else {
            
        
            let notificationType = "Уведомление!"
            
            appDelegate?.scheduleNotification(notifaicationType: notificationType)
            remindersStack.isHidden = false

        }
    }
    
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

    
    @IBAction func fiftyMinutesSwitch(_ sender: UISwitch) {
        if sender.isOn{
            timeSwitches[1].isOn = false
            timeSwitches[2].isOn = false
            timeSwitches[3].isOn = false
            timeSwitches[4].isOn = false
            timeSwitches[5].isOn = false
            timeSwitches[6].isOn = false
        }
    }
    
    @IBAction func thirtyMinutesSwitch(_ sender: UISwitch) {
        if sender.isOn{
            timeSwitches[0].isOn = false
            timeSwitches[2].isOn = false
            timeSwitches[3].isOn = false
            timeSwitches[4].isOn = false
            timeSwitches[5].isOn = false
            timeSwitches[6].isOn = false
        }

    }
    
    @IBAction func oneHourSwitch(_ sender: UISwitch) {
        if sender.isOn{
            timeSwitches[0].isOn = false
            timeSwitches[1].isOn = false
            timeSwitches[3].isOn = false
            timeSwitches[4].isOn = false
            timeSwitches[5].isOn = false
            timeSwitches[6].isOn = false
        }

    }
    
    @IBAction func twoHourSwitch(_ sender: UISwitch) {
        if sender.isOn{
            timeSwitches[0].isOn = false
            timeSwitches[1].isOn = false
            timeSwitches[2].isOn = false
            timeSwitches[4].isOn = false
            timeSwitches[5].isOn = false
            timeSwitches[6].isOn = false
        }

    }
    
    @IBAction func eightHourSwitch(_ sender: UISwitch) {
        if sender.isOn{
            timeSwitches[0].isOn = false
            timeSwitches[1].isOn = false
            timeSwitches[2].isOn = false
            timeSwitches[3].isOn = false
            timeSwitches[5].isOn = false
            timeSwitches[6].isOn = false
        }

    }
    
    @IBAction func twelveHourSwitch(_ sender: UISwitch) {
        if sender.isOn{
            timeSwitches[0].isOn = false
            timeSwitches[1].isOn = false
            timeSwitches[2].isOn = false
            timeSwitches[3].isOn = false
            timeSwitches[4].isOn = false
            timeSwitches[6].isOn = false
        }

    }
    @IBAction func oneDaySwitch(_ sender: UISwitch) {
        if sender.isOn{
            timeSwitches[0].isOn = false
            timeSwitches[1].isOn = false
            timeSwitches[2].isOn = false
            timeSwitches[3].isOn = false
            timeSwitches[4].isOn = false
            timeSwitches[5].isOn = false
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

}
