//
//  DetailViewController.swift
//  TaskManager
//
//  Created by Roman on 05.08.2020.
//  Copyright © 2020 Roman Monakhov. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    var detailViewModel = DetailViewModel()
    
    //MARK: - Outlet
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var coordLabel: UILabel!
    @IBOutlet weak var pickerDate: UILabel!
    
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEditScreen()
        

    }
    


    
    // MARK: - Отрисовка экрана
    private func setupEditScreen() {
        // если выбранная ячейка не пустая, то вызывается метод для навигации
        setupNavigationBar()
        
        // перезаполняем наши Outlets
        nameLabel.text = detailViewModel.nameUpdate()
        descriptionLabel.text = detailViewModel.descriptionUpdate()
        dateLabel.text = detailViewModel.dateUpdate()
        coordLabel.text = "Координаты: \(detailViewModel.currentTask.latitude), \(detailViewModel.currentTask.longitude)"
        map.showAnnotations([detailViewModel.annotation()], animated: true)
        map.showsUserLocation = false
        pickerDate.text = detailViewModel.pickerDate()
        pickerDate.textColor = detailViewModel.textColorDate()
        
        
        
    }
    

    // MARK: - Удаляем место
    func deleteTask() {
        detailViewModel.deleteTask()
        
    }
    
    func completeTask() {
        detailViewModel.completeTask()
    }
    
    
    
    
    
    // MARK: - Navigation вперед

    // При нажатии на ячеку будет открываться информация о ней на другом контроллере
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // если срабатывает такой идентификатор (который мы присвоили), то передаем данные на него
        if segue.identifier == "updateTask" {
            let newPlaceVC = segue.destination as! NewViewController // сразу извлекаем опционал
            
            newPlaceVC.newViewModel.currentTask = detailViewModel.currentTask // и обращаемся к свойству currentPlace из NewPlaceViewController, чтобы передать информацию о ячейке туда
     
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
        
        
        
     
