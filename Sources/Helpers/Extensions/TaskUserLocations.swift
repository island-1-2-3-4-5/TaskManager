//
//  TaskUserLocations.swift
//  TaskManager
//
//  Created by Roman on 12.08.2020.
//  Copyright © 2020 Roman Monakhov. All rights reserved.
//

import MapKit
import CoreLocation



extension MainViewController: CLLocationManagerDelegate{

        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            checkAutorization()
        }
}



extension NewViewController: CLLocationManagerDelegate{

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.last?.coordinate{
                
                newViewModel.latitude = location.latitude
                newViewModel.longitude = location.longitude
             
            }

        }
}



