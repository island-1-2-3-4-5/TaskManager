//
//  PasswordViewController.swift
//  TaskManager
//
//  Created by Roman on 15.08.2020.
//  Copyright © 2020 Roman Monakhov. All rights reserved.
//

import UIKit
import RealmSwift

class PasswordViewController: UITableViewController {

    var settingsViewModel = SettingViewModel()

    
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var oldPasswordLabel: UILabel!
    @IBOutlet weak var newPasswordLabel: UILabel!
    @IBOutlet weak var repeatPasswordLabel: UILabel!
    
    @IBOutlet weak var oldPasswordCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingsViewModel.dataLoad()
        if settingsViewModel.settings[0].password == "" {
            oldPasswordCell.isHidden = true
        }

        oldPasswordTextField.addTarget(self, action: #selector(oldTextFieldChanged), for: .editingChanged)
        newPasswordTextField.addTarget(self, action: #selector(newTextFieldChanged), for: .editingChanged)
        repeatPasswordTextField.addTarget(self, action: #selector(repeatTextFieldChanged), for: .editingChanged)
        
// setupNavigationBar()
        
        
        // убираем разлиновку после ячеек
        tableView.tableFooterView = UIView(frame: CGRect(x: 0,
                                                         y: 0,
                                                         width: tableView.frame.size.width,
                                                         height: 1))
        
        // При нажатии на экран будет срабатывать метод скрывания клавиатуры
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        
        self.tableView.addGestureRecognizer(tapGesture)

    }
    
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        oldPasswordTextField.resignFirstResponder()
        newPasswordTextField.resignFirstResponder()
        repeatPasswordTextField.resignFirstResponder()

    }

    
      // MARK: - Навигация назад Main
//    private func setupNavigationBar() {
//        // если существует Item в навигационном баре, то можно там что-то изменить
//        if let topItem = navigationController?.navigationBar.topItem {
//            // меняем наименование кнопки возврата
//            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//            topItem.backBarButtonItem?.tintColor = .black
//
//        }
//
//        navigationItem.leftBarButtonItem = nil // убираем кнопку cancel, чтобы вместо неё была кнопка back
//
//    }
    
    
    
    func savePassword(){

        guard repeatPasswordTextField.text!.count >= 4 else { return }
        
        guard oldPasswordTextField.text == settingsViewModel.settings[0].password  else { return }
                if newPasswordTextField.text == repeatPasswordTextField.text{
                    try! realm.write{
                        settingsViewModel.settings[0].password = repeatPasswordTextField.text!
                    }
                }
    }
    
    
}



extension PasswordViewController: UITextFieldDelegate{
    
    
    
    @objc private func oldTextFieldChanged(){
        if oldPasswordTextField.text?.isEmpty == false{
            oldPasswordLabel.isHidden = false
        } else {
            oldPasswordLabel.isHidden = true

        }
    }
        
        @objc private func newTextFieldChanged(){
        if newPasswordTextField.text?.isEmpty == false{
            newPasswordLabel.isHidden = false
        } else  {
                newPasswordLabel.isHidden = true

            }
    }
            
        @objc private func repeatTextFieldChanged(){
            if repeatPasswordTextField.text?.isEmpty == false{
                repeatPasswordLabel.isHidden = false
            } else {
                   
                repeatPasswordLabel.isHidden = true


                }
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let currentCharacterCount = textField.text?.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        let newLength = currentCharacterCount + string.count - range.length
        return newLength <= 4
    }
        
        
}

