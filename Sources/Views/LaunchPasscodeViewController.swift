//
//  LaynchPasscodeViewController.swift
//  TaskManager
//
//  Created by Roman on 28.08.2020.
//  Copyright © 2020 Roman Monakhov. All rights reserved.
//

import UIKit
import LocalAuthentication

class LaunchPasscodeViewController: UIViewController {

    var settingsViewModel = SettingViewModel()
    var password = ""
    
    
    
    @IBOutlet var securityView: [UIView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingsViewModel.dataLoad()

        for i in 0..<securityView.count {
            securityView[i].layer.cornerRadius = 8
        }
        
    }
    
    
    
    
    @IBAction func numPad(_ sender: UIButton) {
        
        if password.count <= 3{
        password = password + String(sender.tag)
    
            for i in 0..<password.count {
                securityView[i].backgroundColor = UIColor(rgb: 0x333333)
            }
        }
        
        if password == settingsViewModel.settings[0].password{
            DispatchQueue.main.async {
            // Что-то сделать
            self.dismiss(animated: true, completion: nil)
            }
        }
    }

    
    
    @IBAction func deleteButton(_ sender: UIButton) {
        if password.count != 0 {
            password.removeLast()
            for i in 0..<securityView.count {
                securityView[i].backgroundColor = UIColor(rgb: 0xc4c4c4)
            }
            for i in 0..<password.count {
                securityView[i].backgroundColor = UIColor(rgb: 0x333333)
            }
        }


    }




    @IBAction func useBiometric(_ sender: UIButton) {
        let context = LAContext()

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            
            if settingsViewModel.settings[0].faceIdIsOn && context.biometryType == .faceID{
                
                contextIn(context)

            } else if settingsViewModel.settings[0].touchIdIsOn && context.biometryType == .touchID {
                contextIn(context)
            }
            
        }

    }
    
    
    
    func contextIn(_ context: LAContext){
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Please authenticate to proceed.") { (success, error) in
            if success {
                DispatchQueue.main.async {
                    // Что-то сделать
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                guard let error = error else { return }
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    @IBAction func forgetPassword(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Ваш пароль:", message: "\(settingsViewModel.settings[0].password)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
}
