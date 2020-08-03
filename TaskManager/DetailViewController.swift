//
//  DetailViewController.swift
//  TaskManager
//
//  Created by Roman on 02.08.2020.
//  Copyright © 2020 Roman Monakhov. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {

    var currentTask: Task! // это свойство содержит информацию о текущей выбранной ячейке

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // убираем разлиновку после ячеек
        tableView.tableFooterView = UIView(frame: CGRect(x: 0,
                                                         y: 0,
                                                         width: tableView.frame.size.width,
                                                         height: 1))
        
       
        saveButton.isEnabled = false

         // вызываем метод передачи информации об ячейке
         setupEditScreen()

    }
    
    
    // MARK: - Сохраняем новое место
    func saveTask() {

        // инициализируем с помощью вспомогательного инициализатора
        let newTask = Task(name:nameTextView.text!,
                             descriptionTask: descriptionTextView.text)
        
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
    
    // MARK: - Функция для редактирования
     private func setupEditScreen() {
         if currentTask != nil {
             
             // если выбранная ячейка не пустая, то вызывается метод для навигации
             setupNavigationBar()
            
     
             // перезаполняем наши Outlets
        
             nameTextView.text = currentTask?.name
             descriptionTextView.text = currentTask?.descriptionTask
            
          //  nameLabel.isHidden = true
       //     descriptionLabel.isHidden = true
            
            saveButton.isEnabled = true
         }
     }
    
    //MARK: - Навигация назад Main
      private func setupNavigationBar() {
          // если существует Item в навигационном баре, то можно там что-то изменить
          if let topItem = navigationController?.navigationBar.topItem {
              // меняем наименование кнопки возврата
              topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            topItem.backBarButtonItem?.tintColor = .black
            
          }
        
        
                
          navigationItem.leftBarButtonItem = nil // убираем кнопку cancel, чтобы вместо неё была кнопка back
             
          // делаем кнопку save активной
        
    
          saveButton.isEnabled = true
        
        
      }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
         dismiss(animated: true)
    }
    

   
}




// MARK: - TEXT field delegate

extension DetailViewController: UITextViewDelegate{
   
    //скрываем клавиатуру при нажатии  go
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
               view.endEditing(true)

       }
    
    
    // отслеживаем заполнение названия записи
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
       if nameTextView.text?.isEmpty == false{
                   saveButton.isEnabled = true
               } else {
                   saveButton.isEnabled = false
               }
    }
  
    }


