//
//  MainViewController.swift
//  TaskManager
//
//  Created by Roman on 30.07.2020.
//  Copyright © 2020 Roman Monakhov. All rights reserved.
//

import UIKit
import RealmSwift
import CoreLocation



class MainViewController: UIViewController{

    //MARK: - Свойства
   
    var mainViewModel = MainViewModel()
    var tableViewUpdate = Timer()
    var settings = SettingsViewController()
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var taskIndicator: UILabel!
    
     //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()


        checkLocationEnable()

        // делаем отображение базы данных, делаем запрос к отображаемому типу данных Task
        mainViewModel.tasksData()
        mainViewModel.readTasksAndUpateUI(tableView)
        
        // убираем разлиновку после ячеек
        tableView.tableFooterView = UIView(frame: CGRect(x: 0,
                                                         y: 0,
                                                         width: tableView.frame.size.width,
                                                         height: 1))
        
        tableViewUpdate  = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
        updateIndicator()
        
        settings.settings = realm.objects(Settings.self)
        
        settings.notification()
        tableView.refreshControl = myRefreshControl

    }
    

    //MARK: Обновление контента
       let myRefreshControl: UIRefreshControl = {
           let refreshControl = UIRefreshControl()
           refreshControl.addTarget(self,
                                    action: #selector(refresh(sender:)),
                                    for: .valueChanged)
           return refreshControl
       }()
        
    @objc private func refresh(sender: UIRefreshControl){

        tableView.reloadData()
        settings.notification()

        sender.endRefreshing()
    }
    

    @objc func update(){
        mainViewModel.updateUI(tableView)
        
        
    }

    

    
    
    
    
    //MARK: - Обновление индикатора
    func updateIndicator() {
        if mainViewModel.tasksIsEmpty(){
                   taskIndicator.isHidden = false
               } else {
                   taskIndicator.isHidden = true
               }
    }

    
    // MARK: - Navigation

    // При нажатии на ячеку будет открываться информация о ней на другом контроллере
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // если срабатывает такой идентификатор (который мы присвоили), то передаем данные на него
        if segue.identifier == "showDetail" {
            // обращаемся к выбранной ячейке по индексу
            guard let indexPath = tableView.indexPathForSelectedRow  else {return}

            var task = Task()

           if indexPath.section == 0 {
            task = mainViewModel.expiredTasks[indexPath.row]
           }else if indexPath.section == 1{
            task = mainViewModel.tasks[indexPath.row]
            
           }else{
            task = mainViewModel.completeTasks[indexPath.row]
            }

            let newPlaceVC = segue.destination as! DetailViewController // сразу извлекаем опционал

            newPlaceVC.detailViewModel.currentTask = task // и обращаемся к свойству currentPlace из NewPlaceViewController, чтобы передать информацию о ячейке туда

                               
        }
    }
    
    
    
    //MARK: - Actions navigations
    
    //Выход Segue создаем этот метод для того, чтобы мы могли на него сослаться из последнего контроллера(кнопка cancel)
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        // передаем новое значение в таблицу
        guard let newTaskVC = segue.source as? NewViewController else {return}
        newTaskVC.saveTask()
        // перезагружаем таблицу после добавления объекта и обновляем индикатор
        updateIndicator()
        tableView.reloadData()
        settings.notification()
       }
    
    
    
    // Метод удаления задачи из DetailViewController
    @IBAction func deleteSegue(_ segue: UIStoryboardSegue) {
        // передаем старое значение в таблицу
        guard let deleteTaskVC = segue.source as? DetailViewController else {return}
        // Удаляем задачу из памяти
        deleteTaskVC.deleteTask()
        // Перезагружаем таблицу
        tableView.reloadData()
        // Обновляем индикатор
        updateIndicator()
        settings.notification()
        
    }
    // Метод завершения задачи из DetailViewController
    @IBAction func completeSegue(_ segue: UIStoryboardSegue) {
        // передаем старое значение в таблицу
        guard let completeTaskVC = segue.source as? DetailViewController else {return}
        // Удаляем задачу из памяти
        completeTaskVC.completeTask()
        // Перезагружаем таблицу
        tableView.reloadData()
        // Обновляем индикатор
        updateIndicator()
        settings.notification()
        
    }
    
    
    
    //MARK: - Геопозиция
    // проверка включена ли геолокация
    func checkLocationEnable(){
        if CLLocationManager.locationServicesEnabled(){
            mainViewModel.locationManager.delegate = self
            checkAutorization()
        } else {
            present(mainViewModel.showAlertLocation(title:"У вас выключена служба геолокации", message:"Хотите включить?", url:URL(string: "App-Prefs:root=LOCATION_SERVICES")), animated:  true, completion:  nil)
            
       
        }
    }
    
    // Спрашиваем пользователя на использование его геолокации
    func checkAutorization(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            mainViewModel.locationManager.startUpdatingLocation()
            break
        case .denied:
            present(mainViewModel.showAlertLocation(title: "Вы запретили использование местоположения", message: "Хотите это изменить?", url: URL(string: UIApplication.openSettingsURLString)), animated:  true, completion:  nil)
            break
        case .restricted:
            break
        case .notDetermined:
            mainViewModel.locationManager.requestWhenInUseAuthorization()
        @unknown default:
            print("New case is availeble")
            
        }
    }
}













     // MARK: - extension Tableview
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    //MARK: Заголовок секции
   func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
 
    if let headerView = view as? UITableViewHeaderFooterView {
        headerView.contentView.backgroundColor = .white
        headerView.backgroundView?.backgroundColor = .black
        headerView.textLabel?.textColor = .black
        headerView.textLabel?.font = UIFont(name: "SFUIText-Regular", size: 22.0)
    }
   }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
   
        if section == 0 {
        return mainViewModel.titleForExpiredSection()
        } else if section == 1{
            return mainViewModel.titleForComingSection()
        }
           return mainViewModel.titleForSection()
        
    }

   
    //MARK: Высота заголовка секции
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 && mainViewModel.expiredTasks.count == 0{
            return 0
        } else if section == 1 && mainViewModel.tasks.count == 0{
            return 0
        } else if section == 2 && mainViewModel.completeTasks.count == 0{
            return 0
        }
        return mainViewModel.height
    }
    
    //MARK: Количество секций
    func numberOfSections(in tableView: UITableView) -> Int {
        return mainViewModel.sectionCount
       }

    //MARK: Количество строк
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      if section == 0{
        return mainViewModel.expiredTasks.count
        
      } else if section == 1{
        return mainViewModel.tasks.count
        
      }
        
        return mainViewModel.completeTasks.count
    }
    
    
    
    
    
    
        
    //MARK: - Конфигурация ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainViewCell
        
        var task: Task!
        
        
        if indexPath.section == 0{
            
            
            task = mainViewModel.expiredTasks[indexPath.row]
                       
            // Снимаем зачеркивание
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: task.name)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 0, range: NSMakeRange(0, attributeString.length))
            cell.descriptionLabel.attributedText = attributeString
            cell.descriptionLabel.textColor = .black
            cell.dateLabel.textColor = UIColor(rgb: 0xEB5757)
            cell.dateLabel.text = mainViewModel.dateUpdate(task.pickerDate!)

            
            
            
        } else if indexPath.section == 1{
            
            
            
            task = mainViewModel.tasks[indexPath.row]
    
            // Снимаем зачеркивание
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: task.name)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 0, range: NSMakeRange(0, attributeString.length))
            cell.descriptionLabel.attributedText = attributeString
            cell.descriptionLabel.textColor = .black
            
            
            
            

            let pickerDate = Calendar.current.date(from:             mainViewModel.formatPickerDate(task.pickerDate!, settings.h, settings.m))!

            let date = Calendar.current.date(from:             mainViewModel.formatPickerDate(task.date, 0, 0))!
            
            
            if date < pickerDate {
                cell.dateLabel.textColor = UIColor(rgb: 0x219653)
                cell.dateLabel.text = mainViewModel.dateUpdate(task.pickerDate!)
            } else {
                cell.dateLabel.textColor = UIColor(rgb: 0xF2994A)
                cell.dateLabel.text = mainViewModel.dateUpdate(task.pickerDate!)
            }
            


            
            
        } else if indexPath.section == 2 {
            
            
            
            task = mainViewModel.completeTasks[indexPath.row]
            
            // устанавливаем формат записи в завершенных
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: task.name)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
            cell.descriptionLabel.attributedText = attributeString
            cell.descriptionLabel.textColor = .lightGray
            cell.dateLabel.textColor = UIColor(rgb: 0xBDBDBD)
            cell.dateLabel.text = mainViewModel.dateUpdate(task.pickerDate!)

        }
        


        
        return cell
    }

    
    //MARK: Убираем выделение строк
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    

    // MARK: - Удаление записей
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
                  
        
        let task: Task!
        if indexPath.section == 0 {
         task = mainViewModel.expiredTasks[indexPath.row]
        }else if indexPath.section == 1{
                    task = mainViewModel.tasks[indexPath.row]
                }
                else{
                    task = mainViewModel.completeTasks[indexPath.row]
                }
        
        
        
        // удаляем из таблицы строку с объектом и сам объект из базы данных
        let contextItem = UIContextualAction(style: .destructive,
                                                   title: "✕") {  (_, _, _) in // (contextualAction, view, boolValue)
                                                    StorageManager.deleteObject(task)
                                                    tableView.deleteRows(at: [indexPath], with: .automatic)
                                                    
                                                    self.updateIndicator()
                                                    self.mainViewModel.readTasksAndUpateUI(self.tableView)
                                                    self.settings.notification()

                                                        
                                   
                                                    
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        
        return swipeActions

    }

    
    //MARK: - Перемещение записей
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

       let task: Task!
              if indexPath.section == 0 {
               task = mainViewModel.expiredTasks[indexPath.row]
              }else if indexPath.section == 1{
                          task = mainViewModel.tasks[indexPath.row]
                      }
                      else{
                          task = mainViewModel.completeTasks[indexPath.row]
                      }
        let contextItem = UIContextualAction(style: .normal,
                                            title: "✓") {  (_, _, _) in // (contextualAction, view, boolValue)
           try! realm.write{
            task.isCompleted = true
                                                }

            self.tableView.reloadData()
            self.updateIndicator()
            self.settings.notification()
                     }


        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])

        return swipeActions
    }
    

}




