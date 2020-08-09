//
//  DetailViewController.swift
//  TaskManager
//
//  Created by Roman on 05.08.2020.
//  Copyright © 2020 Roman Monakhov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var currentTask: Task!
    
    
    //MARK: - Outlet
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEditScreen()
    }
    

    
    //MARK: - Actions
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    

    
    // MARK: - Отрисовка экрана
    private func setupEditScreen() {
                 
        let date = currentTask.createdAt!
        let format = DateFormatter()
        format.locale = Locale(identifier: "ru_RU")
        format.dateFormat = "HH:mm dd MMMM yyyy"
        let formattedDate = format.string(from: date)
        
        // если выбранная ячейка не пустая, то вызывается метод для навигации
        setupNavigationBar()
         
        // перезаполняем наши Outlets
        nameLabel.text = currentTask?.name
        descriptionLabel.text = currentTask?.descriptionTask
        dateLabel.text = formattedDate
                  
    }
    
    
    // MARK: - Удаляем место
    func deleteTask() {
        StorageManager.deleteObject(currentTask)
    }
    
    
    func completeTask() {
        try! realm.write{
            
            currentTask?.isCompleted = true
        }
    }
    
    // MARK: - Navigation вперед

    // При нажатии на ячеку будет открываться информация о ней на другом контроллере
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // если срабатывает такой идентификатор (который мы присвоили), то передаем данные на него
        if segue.identifier == "updateTask" {
            let newPlaceVC = segue.destination as! NewViewController // сразу извлекаем опционал
            
            newPlaceVC.currentTask = currentTask // и обращаемся к свойству currentPlace из NewPlaceViewController, чтобы передать информацию о ячейке туда
     
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
