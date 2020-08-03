//
//  MainViewController.swift
//  TaskManager
//
//  Created by Roman on 30.07.2020.
//  Copyright © 2020 Roman Monakhov. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var taskIndicator: UILabel!
 
    
    //MARK: - Свойства
    private  var tasks: Results<Task>!
    
    
     //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        // делаем отображение базы данных, делаем запрос к отображаемому типу данных Place
        tasks = realm.objects(Task.self)
        
        
        
        // убираем разлиновку после ячеек
        tableView.tableFooterView = UIView(frame: CGRect(x: 0,
                                                         y: 0,
                                                         width: tableView.frame.size.width,
                                                         height: 1))
        
    
        updateIndicator()
    }

    
    
    func updateIndicator() {
         if tasks.isEmpty{
                   taskIndicator.isHidden = false
               } else {
                   taskIndicator.isHidden = true
               }
    }
    
    
      // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           // #warning Incomplete implementation, return the number of rows
        return tasks.count
    
       }
    
    
    //MARK: - Конфигурация ячейки
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainViewCell

    var task = Task()
    task = tasks[indexPath.row]
    cell.descriptionLabel.text = task.name
  
    return cell
     
}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
             tableView.deselectRow(at: indexPath, animated: true)
         }

    
      // MARK: - Удаление записей
    
      
      func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
          
          let task = tasks[indexPath.row]
          // удаляем из таблицы строку с объектом и сам объект из базы данных
          let contextItem = UIContextualAction(style: .destructive,
                                               title: "Delete") {  (_, _, _) in // (contextualAction, view, boolValue)
              StorageManager.deleteObject(task)
              tableView.deleteRows(at: [indexPath], with: .automatic)
                                                
                                                self.updateIndicator()
          }
          let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])

        
          return swipeActions

      }
      
    
    // MARK: - Navigation

        // При нажатии на ячеку будет открываться информация о ней на другом контроллере
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          // если срабатывает такой идентификатор (который мы присвоили), то передаем данные на него
            if segue.identifier == "showDetail" {
                // обращаемся к выбранной ячейке по индексу
                guard let indexPath = tableView.indexPathForSelectedRow  else {return}
           
                var task = Task()
   
                task = tasks[indexPath.row]
                
                
                let newPlaceVC = segue.destination as! DetailViewController // сразу извлекаем опционал
                newPlaceVC.currentTask = task // и обращаемся к свойству currentPlace из NewPlaceViewController, чтобы передать информацию о ячейке туда
            }
        }
    
    
    // MARK: - Выход Segue
       // создаем этот метод для того, чтобы мы могли на него сослаться из последнего контроллера(кнопка cancel)
       @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
           
           // передаем новое значение в таблицу
           guard let newTaskVC = segue.source as? DetailViewController else {return}
           
           
           newTaskVC.saveTask()
           // перезагружаем таблицу после добавления объекта
        
        updateIndicator()
           tableView.reloadData()
       }
}
