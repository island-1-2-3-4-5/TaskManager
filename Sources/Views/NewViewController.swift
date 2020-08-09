//
//  NewViewController.swift
//  TaskManager
//
//  Created by Roman on 02.08.2020.
//  Copyright © 2020 Roman Monakhov. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {

    
    //MARK: - Свойства
    var currentTask: Task! // это свойство содержит информацию о текущей выбранной ячейке
    let date = Date()
   

    //MARK: - Outlet
    @IBOutlet weak var viewInView: UIView!
    @IBOutlet weak var saveAction: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var bottomConstraintTextVIew: NSLayoutConstraint!
    
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveAction.isEnabled = false
        saveButton.isEnabled = false
        nameTextView.isHidden = true
        descriptionTextView.isHidden = true
        
        // вызываем метод передачи информации об ячейке
        setupEditScreen()
        
        // При нажатии на экран будет срабатывать метод скрывания клавиатуры
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    
    //MARK: - Убираем клавиатуру
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        nameTextView.resignFirstResponder()
        descriptionTextView.resignFirstResponder()
    }
 
    // MARK: - Сохраняем место
    func saveTask() {
        
        // инициализируем с помощью вспомогательного инициализатора
        let newTask = Task(name:nameTextView.text!,
                           descriptionTask: descriptionTextView.text, createdAt: date, isCompleted: false)

        if currentTask != nil {
                   try! realm.write{
                       currentTask?.name = newTask.name
                       currentTask?.descriptionTask = newTask.descriptionTask
                   }
               } else {
                   // сохраняем новый объект в базе
                   StorageManager.saveObject(newTask)
               }
        
    }
    
    
    //MARK: - Action
    @IBAction func hiddenNameText(_ sender: UIButton) {
        nameTextView.isHidden = false
    }
    
    @IBAction func hiddenDescriptionText(_ sender: UIButton) {
        descriptionTextView.isHidden = false
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
         dismiss(animated: true)
    }
    

    // MARK: - Редактирование
    private func setupEditScreen() {
        if currentTask != nil {
                    
            // если выбранная ячейка не пустая, то вызывается метод для навигации
            setupNavigationBar()
       
            // перезаполняем наши Outlets
            nameTextView.text = currentTask?.name
            descriptionTextView.text = currentTask?.descriptionTask
            nameTextView.isHidden = false
            descriptionTextView.isHidden = false
            navigationItem.title = "РЕДАКТИРОВАНИЕ"
            saveAction.isEnabled = true
            saveButton.isEnabled = true
                    
        }
        
    }
    
    //MARK: - Навигация назад Main
    private func setupNavigationBar() {
        // если существует Item в навигационном баре, то можно там что-то изменить
        if let topItem = navigationController?.navigationBar.topItem {
            // меняем наименование кнопки возврата

            topItem.backBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: nil, action: nil)
            topItem.backBarButtonItem?.tintColor = .black
            
        }
        navigationItem.leftBarButtonItem = nil // убираем кнопку cancel, чтобы вместо неё была кнопка back
        
    }

 
}


// MARK: - TextView delegate

extension NewViewController: UITextViewDelegate{

    
    // отслеживаем заполнение названия записи
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
        if nameTextView.text?.isEmpty == false{
            saveButton.isEnabled = true
            saveAction.isEnabled = true
                } else {
            saveButton.isEnabled = false
            saveAction.isEnabled = false
                }
    }
    
    
    // считаем количество символов
      func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    
        if textView == nameTextView {
            return textView.text.count + (text.count - range.length) <= 100
        } else {
            return textView.text.count + (text.count - range.length) <= 1000
        }
        
      }

}


