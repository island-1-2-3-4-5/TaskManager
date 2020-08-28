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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }



    @IBAction func useBiometric(_ sender: UIButton) {
        let context = LAContext()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
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

    }
    
}
