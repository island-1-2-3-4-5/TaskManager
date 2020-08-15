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

    
    
    @IBAction func remindersSwitch(_ sender: UISwitch) {
        if sender.isOn == false{
            remindersStack.isHidden = true
        } else {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupNavigationBar()
        // Do any additional setup after loading the view.
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
