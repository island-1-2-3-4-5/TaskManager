//
//  DetailViewController.swift
//  TaskManager
//
//  Created by Roman on 05.08.2020.
//  Copyright © 2020 Roman Monakhov. All rights reserved.
//

import UIKit
import MapKit
//import CoreLocation

class DetailViewController: UIViewController {

    var detailViewModel = DetailViewModel()
    
    //MARK: - Outlet
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var coordLabel: UILabel!
    
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEditScreen()
        coordLabel.text = "Координаты: \(String(describing: detailViewModel.currentTask.latitude)), \(String(describing: detailViewModel.currentTask.longitude))"

        
        
        let region = MKCoordinateRegion(center: .init(latitude: detailViewModel.currentTask.latitude, longitude: detailViewModel.currentTask.longitude), latitudinalMeters: 500, longitudinalMeters: 500)
        
        map.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate.latitude = detailViewModel.currentTask.latitude
        annotation.coordinate.longitude = detailViewModel.currentTask.longitude
        map.showAnnotations([annotation], animated: true)
        map.showsUserLocation = false
    }
    

    
    //MARK: - Actions
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    

    
    // MARK: - Отрисовка экрана
    private func setupEditScreen() {
        // если выбранная ячейка не пустая, то вызывается метод для навигации
        setupNavigationBar()
        
        // перезаполняем наши Outlets
        nameLabel.text = detailViewModel.nameUpdate()
        descriptionLabel.text = detailViewModel.descriptionUpdate()
        dateLabel.text = detailViewModel.dateUpdate()
                  
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

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    let locationManager = CLLocationManager()
    
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        checkLocationEnable()
//    }
//
//    // проверка включена ли геолокация
//    func checkLocationEnable(){
//        if CLLocationManager.locationServicesEnabled(){
//            setupManager()
//            checkAutorization()
//        } else {
//        //    showAlertLocation(title:"У вас выключена служба геолокации", message:"Хотите включить?", url:URL(string: "App-Prefs:root=LOCATION_SERVICES"))
//
//        }
//    }
//
//
//
//    func setupManager(){
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//    }
//
//
//    // Спрашиваем пользователя на использование его геолокации
//    func checkAutorization(){
//        switch CLLocationManager.authorizationStatus() {
//        case .authorizedAlways:
//            break
//        case .authorizedWhenInUse:
//            map.showsUserLocation = true
//            locationManager.startUpdatingLocation()
//            break
//        case .denied:
//        //    showAlertLocation(title: "Вы запретили использование местоположения", message: "Хотите это изменить?", url: URL(string: UIApplication.openSettingsURLString))
//            break
//        case .restricted:
//            break
//        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
//        @unknown default:
//            print("New case is availeble")
//
//        }
    }
        
        
        
        
//    func showAlertLocation(title:String, message:String?, url:URL?){
//
//
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//
//        let settingsActions = UIAlertAction(title: "Настройки", style: .default) { (alert) in
//            if let url = url{
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
//            }
//        }
//
//        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
//
//        alert.addAction(settingsActions)
//        alert.addAction(cancelAction)
//
//        present(alert, animated:  true, completion:  nil)
//    }
        

//
//extension DetailViewController: CLLocationManagerDelegate{
//
////    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
////            if let location = locations.last?.coordinate{
////
////                let region = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
////                map.setRegion(region, animated: true)
////            }
////        coordLabel.text = "Координаты: \(String(describing: locations.last!.coordinate.latitude)), \(String(describing: locations.last!.coordinate.longitude))"
////        }
////
////        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
////            checkAutorization()
////        }
//}
